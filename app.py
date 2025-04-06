from flask import Flask, request, jsonify
from flask_cors import CORS
import google.generativeai as genai
import os
import PyPDF2
from PIL import Image
import io
import base64
import tempfile
import logging
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for Flutter app integration

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Configure Gemini API
GOOGLE_API_KEY = os.getenv('GOOGLE_API_KEY')
if not GOOGLE_API_KEY:
    logger.error("GOOGLE_API_KEY not found in environment variables")
    raise ValueError("Google API key is required. Please set GOOGLE_API_KEY in .env file")

genai.configure(api_key=GOOGLE_API_KEY)

# Initialize the Gemini model with legal-specific configuration
legal_model = genai.GenerativeModel('gemini-pro')
legal_model_vision = genai.GenerativeModel('gemini-pro-vision')

# Legal system prompt template
LEGAL_SYSTEM_PROMPT = """
You are a legal assistant specialized in Indian law. Provide accurate, concise, 
and practical legal advice based on the Indian legal system. When asked about 
specific cases, refer to relevant sections of Indian law and landmark judgments. 

Guidelines:
1. Always cite relevant Indian laws and sections when possible
2. Mention landmark judgments if applicable
3. Provide balanced views on both sides of legal arguments
4. Clarify when a question requires consultation with a licensed advocate
5. For state-specific queries, ask for clarification about the state
6. Never provide false or misleading information
7. If unsure, state that you cannot answer definitively

Current year: 2024. Always consider the latest amendments to laws.
"""

# Document analysis prompt
DOCUMENT_ANALYSIS_PROMPT = """
Analyze this legal document and provide:
1. Document type (contract, petition, judgment, etc.)
2. Key parties involved
3. Main legal issues
4. Important clauses/terms
5. Potential legal concerns
6. Relevant Indian laws/cases
7. Summary of the document

Be thorough but concise. Format the response with clear headings.
"""

def extract_text_from_pdf(pdf_bytes):
    """Extract text from PDF bytes"""
    try:
        with tempfile.NamedTemporaryFile(delete=False) as temp_file:
            temp_file.write(pdf_bytes)
            temp_file_path = temp_file.name
        
        text = ""
        with open(temp_file_path, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            for page in reader.pages:
                text += page.extract_text() or ""
        
        os.unlink(temp_file_path)
        return text
    except Exception as e:
        logger.error(f"Error extracting PDF text: {e}")
        return None

def process_image(image_bytes):
    """Process image bytes for Gemini Vision"""
    try:
        image = Image.open(io.BytesIO(image_bytes))
        return image
    except Exception as e:
        logger.error(f"Error processing image: {e}")
        return None

@app.route('/api/legal_chat', methods=['POST'])
def legal_chat():
    """Endpoint for legal chatbot queries"""
    try:
        data = request.json
        user_query = data.get('query', '')
        chat_history = data.get('history', [])
        
        if not user_query:
            return jsonify({"error": "Query is required"}), 400
        
        # Start chat with system prompt
        chat = legal_model.start_chat(history=chat_history)
        
        # Combine system prompt with user query
        full_prompt = f"{LEGAL_SYSTEM_PROMPT}\n\nUser Query: {user_query}"
        
        response = chat.send_message(full_prompt)
        
        return jsonify({
            "response": response.text,
            "history": chat.history
        })
    except Exception as e:
        logger.error(f"Error in legal_chat: {e}")
        return jsonify({"error": str(e)}), 500

@app.route('/api/analyze_document', methods=['POST'])
def analyze_document():
    """Endpoint for document analysis"""
    try:
        if 'file' not in request.files and 'base64' not in request.form:
            return jsonify({"error": "No file or base64 data provided"}), 400
        
        file = None
        file_bytes = None
        
        # Handle file upload
        if 'file' in request.files:
            file = request.files['file']
            file_bytes = file.read()
        # Handle base64 data (common from Flutter)
        elif 'base64' in request.form:
            base64_data = request.form['base64'].split(',')[-1]  # Remove data URI prefix if present
            file_bytes = base64.b64decode(base64_data)
        
        if not file_bytes:
            return jsonify({"error": "Could not read file data"}), 400
        
        # Determine file type
        file_type = None
        if file:
            file_type = file.content_type
        else:
            # Simple content type detection from bytes
            if file_bytes.startswith(b'%PDF'):
                file_type = 'application/pdf'
            elif file_bytes.startswith(b'\xFF\xD8') or file_bytes.startswith(b'\x89PNG'):
                file_type = 'image/jpeg' if file_bytes.startswith(b'\xFF\xD8') else 'image/png'
        
        # Process based on file type
        if file_type == 'application/pdf':
            text = extract_text_from_pdf(file_bytes)
            if not text:
                return jsonify({"error": "Could not extract text from PDF"}), 400
            
            response = legal_model.generate_content(f"{DOCUMENT_ANALYSIS_PROMPT}\n\nDocument Text:\n{text}")
            return jsonify({"analysis": response.text})
        
        elif file_type and file_type.startswith('image/'):
            image = process_image(file_bytes)
            if not image:
                return jsonify({"error": "Could not process image"}), 400
            
            response = legal_model_vision.generate_content([DOCUMENT_ANALYSIS_PROMPT, image])
            return jsonify({"analysis": response.text})
        
        else:
            return jsonify({"error": "Unsupported file type"}), 400
        
    except Exception as e:
        logger.error(f"Error in analyze_document: {e}")
        return jsonify({"error": str(e)}), 500

@app.route('/')
def home():
    return "Legal Assistant API is running. Use /api/legal_chat or /api/analyze_document endpoints."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
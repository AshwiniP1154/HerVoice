const { GoogleGenerativeAI } = require("@google/generative-ai");
require("dotenv").config();

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

async function getLegalResponse(prompt) {
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });
    
    const legalPrompt = `
    You are a legal assistant specialized in Indian law. 
    Provide accurate, concise legal advice based on Indian statutes and precedents.
    
    Question: ${prompt}
    `;
    
    const result = await model.generateContent(legalPrompt);
    const response = await result.response;
    return response.text();
}

// Test the function
getLegalResponse("What are the key provisions of the Indian Contract Act?")
    .then(text => console.log(text))
    .catch(err => console.error(err));
require('dotenv').config();
const jwt = require('jsonwebtoken');

function generateJWT(userID) {
  const secret_token = process.env.Jwt_token; 
  if (!secret_token) {
    throw new Error("JWT secret key is not set in environment variables.");
  }
  

  const token = jwt.sign({ userId: userID }, secret_token, { expiresIn: '30m' });
  return token;
}

function validateJWT(token) {
  const secret_token = process.env.Jwt_token;

  try {
    
    const decoded = jwt.verify(token, secret_token);
    return decoded; 
  } catch (error) {
    throw new Error('Invalid or expired token');
  }
}

function authMiddleware(req, res, next) {
  const token = req.headers.authorization?.split(" ")[1];
  const secret_token = process.env.Jwt_token;
  if (!token) {
    return res.status(401).json({ error: "Access denied. No token provided." });
  }

  try {
    const decoded = jwt.verify(token, secret_token);
    req.user = decoded; // Attach decoded user info to request
    next(); 
  } catch (error) {
    return res.status(403).json({ error: "Invalid or expired token." });
  }
}




module.exports = {generateJWT,validateJWT,authMiddleware};

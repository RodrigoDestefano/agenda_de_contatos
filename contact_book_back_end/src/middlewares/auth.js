const jwt = require('jsonwebtoken');

// Import the hash online generated in the auth.json file 
const authConfig = require('../config/auth.json');

module.exports = (req, res, next) => {
  // Two parts Token: Bearer + hash, splited by one space
  const authHeader = req.headers.authorization;

  // This conditionals returns some specific errors in case of no authentication
  if (!authHeader)
    return res.status(401).send({error: 'No token provider'});
  
  const parts = authHeader.split(' ');

  if (!parts.length == 2)
    return res.status(401).send({error: 'Token error!'});

  const [scheme, token] = parts;

  if (!/^Bearer$/i.test(scheme))
    return res.status(401).send({error: 'Token malFormatted'});
  
  jwt.verify(token, authConfig.secret, (e, decoded) => {
    if (e) return res.status(401).send({error: 'Token invalid'});

    req.user_id = decoded.id;
    
    return next();
  });
};
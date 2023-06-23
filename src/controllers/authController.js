const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const hashPass = (pass) => {
  return bcrypt.hashSync(pass, 10);
};

const comparePass = (pass, hashPassword) => {
  return bcrypt.compareSync(pass, hashPassword);
};

const generateToken = (data, exp) => {
  let token = jwt.sign(data, "NguyenVanPhap", {
    algorithm: "HS256",
    expiresIn: exp,
  });
  return token;
};

const verifyToken = (token) => {
  try {
    return jwt.verify(token, "NguyenVanPhap");
  } catch (err) {
    return false;
  }
};
module.exports = {
  hashPass,
  comparePass,
  generateToken,
  verifyToken,
};

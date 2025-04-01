const AuthService = require("../services/auth.service");

const register = async (req, res) => {
  try {
    const user = await AuthService.registerUser(req.body);
    res.status(201).json({ message: "User registered successfully", user });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

const login = async (req, res) => {
  try {
    const { token, user } = await AuthService.loginUser(req.body);
    res.cookie("token", token, { httpOnly: true, secure: true });
    res.json({ message: "Login successful", user });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
};

module.exports = { register, login };

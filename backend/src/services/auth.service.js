const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const UserRepository = require("../repositories/user.repository");

const registerUser = async ({ username, email, password, avatar }) => {
  const existingUser = await UserRepository.findUserByEmail(email);
  if (existingUser) throw new Error("User already exists");

  const hashedPassword = await bcrypt.hash(password, 10);
  return await UserRepository.createUser({
    username,
    email,
    password: hashedPassword,
    avatar,
  });
};

const loginUser = async ({ email, password }) => {
  const user = await UserRepository.findUserByEmail(email);
  if (!user) throw new Error("Invalid credentials");

  const isPasswordValid = await bcrypt.compare(password, user.password);
  if (!isPasswordValid) throw new Error("Invalid credentials");

  const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, {
    expiresIn: "7d",
  });

  return { token, user };
};

module.exports = { registerUser, loginUser };

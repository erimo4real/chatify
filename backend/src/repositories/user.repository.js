const User = require("../models/user.model");

const findUserByEmail = async (email) => await User.findOne({ email });
const findUserById = async (id) => await User.findById(id);
const createUser = async (userData) => await User.create(userData);

module.exports = { findUserByEmail, findUserById, createUser };

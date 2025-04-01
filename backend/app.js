const express = require("express");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const connectDB = require("./config/db");
const authRoutes = require("./routes/auth.routes");

require("dotenv").config();

const app = express();

// Middlewares
app.use(express.json());
app.use(cors({ credentials: true, origin: process.env.CLIENT_URL }));
app.use(cookieParser());

// Routes
app.use("/api/auth", authRoutes);

// Connect to DB
connectDB();

module.exports = app;

const express = require('express');
const jwt = require('jsonwebtoken');
const mysql = require('mysql2/promise');
require('dotenv').config();

const router = express.Router();

// MySQL pool
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT
});

// Middleware to protect routes
const authenticate = (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader) return res.status(401).json({ error: 'No token provided' });

  const token = authHeader.split(' ')[1];
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (err) {
    return res.status(403).json({ error: 'Invalid token' });
  }
};

// Search route
router.get('/search', authenticate, async (req, res) => {
  const { q } = req.query; // search term
  try {
    const sql = 'SELECT * FROM products WHERE name LIKE ?';
    const [rows] = await pool.query(sql, [`%${q}%`]);
    res.json({ results: rows });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;

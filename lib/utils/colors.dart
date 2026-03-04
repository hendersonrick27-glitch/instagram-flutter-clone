import 'package:flutter/material.dart';

// Koinos colour palette - black + forest green theme
const Color kBlack = Color(0xFF000000);                // Main background
const Color kForestGreen = Color(0xFF1B4D3E);          // Primary accent (buttons, highlights)
const Color kDarkGrey = Color(0xFF121212);             // Cards, secondary backgrounds
const Color kLightText = Color(0xFFE0E0E0);            // Main text on dark bg
const Color kMutedGreen = Color(0xFF2E7D32);           // Optional softer green for secondary accents
const Color kErrorRed = Color(0xFFCF6679);             // For errors/alerts

// Legacy names kept for compatibility with existing code
const mobileBackgroundColor = kBlack;
const webBackgroundColor = kDarkGrey;
const mobileSearchColor = kDarkGrey;

const primaryColor = kForestGreen;
const secondaryColor = kMutedGreen;

// Optional: If the app used blue for anything important
const accentColor = kForestGreen;  // Replace old blueColor

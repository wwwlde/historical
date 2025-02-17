# Huffman Encoding in Delphi 7

This project is an implementation of **Huffman encoding** in **Delphi 7**. I originally wrote this code in **2008** as a coursework project for **Object-Oriented Programming (OOP)**.

## **About the Project**
Huffman encoding is a **lossless data compression algorithm** that assigns shorter binary codes to more frequent characters, reducing overall storage size. It is widely used in **data compression**, such as **ZIP files, MP3 encoding, and JPEG compression**.

## **How It Works**
1. The program **analyzes the frequency** of characters in a given input string.
2. It **builds a Huffman tree** based on character frequencies.
3. Each character is assigned a **unique binary code**, with more frequent characters having shorter codes.
4. The encoded binary sequence can be **decoded back** into the original text using the same tree.

## **Why I Wrote This**
This was my **coursework project for OOP** in 2008. The goal was to apply **object-oriented principles** in Delphi, working with **classes, trees, and recursion**. While it's a simple implementation, it effectively demonstrates how Huffman encoding works.

## **Project Structure**
- `Project1.dpr` – Main project file, initializes the application.
- `CHuffman.pas` – Core Huffman encoding logic (tree building, encoding, decoding).
- `Huffman.pas` – User interface logic and integration with Delphi forms.
- `Huffman.dfm` – Form design for the GUI.

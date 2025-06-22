#!/bin/bash

echo "🔍 Verificando dependencias..."

if ! command -v pip &> /dev/null; then
    echo "❌ pip no está instalado."
    exit 1
fi

if ! command -v jupyter &> /dev/null; then
    echo "❌ Jupyter no está instalado. Instalando..."
    pip install notebook
fi

echo "✅ Dependencias básicas OK."

echo "📦 Instalando librerías..."
pip install -r requirements.txt

DATA_FILE="data/world-data-2023.csv"
if [ ! -f "$DATA_FILE" ]; then
    echo "❌ No se encontró $DATA_FILE"
    exit 1
fi

NOTEBOOK="notebooks/world_data_2023.ipynb"
OUTPUT="notebooks/world_data_2023_output.html"

echo "🚀 Ejecutando notebook..."
jupyter nbconvert --to html --execute "$NOTEBOOK" --output "$OUTPUT" --ExecutePreprocessor.timeout=600

echo "✅ Listo. Abre $OUTPUT en tu navegador."

# Fine-Tuning TinyBERT on SST-2

**Course:** DATA 785: Deep Learning · **Stack:** PyTorch, Hugging Face Transformers

Fine-tuning an encoder-only transformer (TinyBERT) for binary sentiment classification on
the SST-2 dataset. Covers the full loop: tokenization, data loading, training,
checkpointing, and evaluation.

## Contents

- `tinybert_sst2_finetuning.ipynb`: the fine-tuning notebook (data load, train, evaluate)

## Note on model weights

The trained checkpoints (`checkpoint-2105`, `-4210`, `-6315`) are not committed; they are
large binary artifacts. The notebook regenerates them from scratch, so re-running the
training cells reproduces the fine-tuned model.

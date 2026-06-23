return {
  {
    'laytan/cloak.nvim',
    ft = 'env',
    opts = {
      cloak_length = 12,
      patterns = {
        {
          file_pattern = '*.env*',
          cloak_pattern = '([_%w]+=).+',
          replace = '%1',
        },
      },
    },
  },
}

{
  # このFlakeには依存がないのでinputsを省略
  # inputs = { };

  outputs = _inputs: {
    hello = "Hello, world!";
  };
}

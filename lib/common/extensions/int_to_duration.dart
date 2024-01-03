extension ToDuration on int {
  get s => Duration(seconds: this);
  get ms => Duration(milliseconds: this);
}

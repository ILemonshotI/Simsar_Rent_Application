class DateFilter {
  DateTime? start;
  DateTime? end;

  DateFilter({this.start, this.end});

  DateFilter copy() {
    return DateFilter(
      start: start,
      end: end,
    );
  }
}
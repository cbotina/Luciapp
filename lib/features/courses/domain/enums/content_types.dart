enum ContentTypes { video, game }

extension StringToContentType on String {
  ContentTypes toContentType() {
    if (this == 'video') return ContentTypes.video;
    if (this == 'game') return ContentTypes.game;

    return ContentTypes.video;
  }
}

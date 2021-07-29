mixin SearchableEntity {
  String get keyphrase;

  void onInvokeFromSearch();

  bool register() => allEntities.add(this);

  bool unregister() => allEntities.remove(this);

  static final allEntities = <SearchableEntity>{};
}

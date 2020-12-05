class MyData {
  int id;
  String _title;
  String _deskripsi;
  String _karya;
  String _createDate;
  String _updateDate;
  String _sortDate;

  MyData(this._title, this._karya, this._deskripsi, this._createDate, this._updateDate,
      this._sortDate);

  MyData.map(dynamic data) {
    this._title = data["title"];
    this._deskripsi = data["deskripsi"];
    this._karya = data["karya"];
    this._createDate = data["createDate"];
    this._updateDate = data["updateDate"];
    this._sortDate = data["sortDate"];
  }

  String get title => _title;
  String get deskripsi => _deskripsi;
  String get karya => _karya;
  String get createDate => _createDate;
  String get updateDate => _updateDate;
  String get sortDate => _sortDate;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["title"] = _title;
    map["deskripsi"] = _deskripsi;
    map["karya"] = _karya;
    map["createDate"] = _createDate;
    map["updateDate"] = _updateDate;
    map["sortDate"] = _sortDate;

    return map;
  }

  void setDataId(int id) {
    this.id = id;
  }
}

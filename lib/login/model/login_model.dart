class LoginModel {
  String? name;
  bool? isAdmin, isBranchAdmin;

  List<String>? branches;

  String? errorMsg;

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isAdmin = json['is_admin'];
    isBranchAdmin = json['is_branch_admin'];
    branches = [];
    if (json['is_admin']) {
      for (var branch in json["branches"]) {
        branches!.add(branch["branch_name"]);
      }
    } else if (json['is_branch_admin']) {
      branches!.add(json["branches"]["branch_name"]);
    }
  }

  LoginModel.withError(String error) : errorMsg = error;
}

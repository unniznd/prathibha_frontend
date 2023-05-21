class LoginModel {
  String? name;
  bool? isAdmin, isBranchAdmin;

  List<String>? branches;
  Map<String, int>? branchMap = {};

  String? errorMsg;

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isAdmin = json['is_admin'];
    isBranchAdmin = json['is_branch_admin'];
    branches = [];
    branchMap = {};
    if (json['is_admin']) {
      for (var branch in json["branches"]) {
        branches!.add(branch["branch_name"]);
        branchMap![branch["branch_name"]] = branch["branch_id"];
      }
    } else if (json['is_branch_admin']) {
      branches!.add(json["branches"]["branch_name"]);
      branchMap![json["branches"]["branch_name"]] =
          json["branches"]["branch_id"];
    }
  }

  LoginModel.withError(String error) : errorMsg = error;
}

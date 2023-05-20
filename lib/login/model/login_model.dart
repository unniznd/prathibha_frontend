class LoginModel {
  String? name;
  bool? isAdmim, isBranchAdmin;

  List<String>? branches;

  String? errorMsg;

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isAdmim = json['is_admin'];
    isBranchAdmin = json['is_branch_admin'];
    // if (json['is_branch_admin']) {
    //   branches!.add(json["branches"]["branch_name"]);
    // } else if (json['is_admin']) {
    //   for (var branch in json["branches"]) {
    //     branches!.add(branch["branch_name"]);
    //   }
    // }
  }

  LoginModel.withError(String error) : errorMsg = error;
}

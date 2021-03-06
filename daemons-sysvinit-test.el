(load-file "./daemons-sysvinit.el")

(ert-deftest sysvinit-parse-list-item-test ()
  (let ((input "NetworkManager  0:off   1:off   2:on    3:on    4:on    5:on    6:off")
        (expected '("NetworkManager" ["NetworkManager" "0:off" "1:off" "2:on" "3:on" "4:on" "5:on" "6:off"])))
    (should (equal expected
                   (daemons-sysvinit--parse-list-item input)))))

(ert-deftest sysvinit-list-test ()
  (let* ((dummy-output "
NetworkManager  0:off   1:off   2:on    3:on    4:on    5:on    6:off
abrt-ccpp       0:off   1:off   2:off   3:on    4:off   5:on    6:off
abrt-oops       0:off   1:off   2:off   3:on    4:off   5:on    6:off")
         (daemons--shell-command-to-string-fun (lambda (_) dummy-output))
         (expected '(("NetworkManager" ["NetworkManager" "0:off" "1:off" "2:on" "3:on" "4:on" "5:on" "6:off"])
                     ("abrt-ccpp" ["abrt-ccpp" "0:off" "1:off" "2:off" "3:on" "4:off" "5:on" "6:off"])
                     ("abrt-oops" ["abrt-oops" "0:off" "1:off" "2:off" "3:on" "4:off" "5:on" "6:off"]))))
    (should (equal expected
                   (daemons-sysvinit--list)))))

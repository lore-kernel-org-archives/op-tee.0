From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE v3.17 S-EL1 SPMC status
Date: Tue, 03 May 2022 16:08:37 +0200
Message-ID: <9E76137B-DD0A-4BBB-9D5E-BCC178DBD9F3@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8195764717710722023=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8195764717710722023==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

This is a follow-up email to the OP-TEE v3.17 release, highlighting the
updates to the SPMC component. As you might know there is a forked
version living at [1], and we are continuously working on moving all
features to upstream.

This version enables all PSA Secure Partitions implemented by Trusted
Services to work with the upstream SPMC. For more information about the
PSA SPs, please see [2].

Short summary of introduced changes:
  - Added support to process the SP manifests in the SPMC.
    The device MMIO regions described in the SP manifest are mapped into
    the SP's translation regime, as requested by FF-A.
  - Added support for the FF-A v1.0 partition boot protocol.
    The SPMC will pass information to the S-EL0 SPs about the device
    regions mapped. The boot information is passed in device tree
    format, using the same bindings as the SP manifest [3].
  - Forward TPM Event Log to S-EL0 SPs.

For more details on how to get, build and test the SPMC, please see [4].

If you have any questions, please do not hesitate to reach out to us via
[5] or [6].

Regards,
Balint on behalf of the Trusted Services team

[1] https://git.trustedfirmware.org/OP-TEE/optee_os.git/log/?h=3Dpsa-developm=
ent
[2] https://trusted-services.readthedocs.io/en/integration
[3] https://trustedfirmware-a.readthedocs.io/en/latest/components/ffa-manifes=
t-binding.html
[4] https://developer.trustedfirmware.org/w/trusted-services/op-tee-spmc
[5] https://lists.trustedfirmware.org/mailman3/lists/op-tee.lists.trustedfirm=
ware.org
[6] https://lists.trustedfirmware.org/mailman3/lists/trusted-services.lists.t=
rustedfirmware.org

--===============8195764717710722023==--


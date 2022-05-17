From: Gyorgy Szing <Gyorgy.Szing@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: OP-TEE v3.17 S-EL1 SPMC status
Date: Tue, 17 May 2022 14:41:50 +0000
Message-ID: <PA4PR08MB590284B5DD2F348EEDC9E9FE91CE9@PA4PR08MB5902.eurprd08.prod.outlook.com>
In-Reply-To: <9E76137B-DD0A-4BBB-9D5E-BCC178DBD9F3@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7818311651335178566=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7818311651335178566==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

Patches adding support for the FF-A TEE driver have been merged to the integr=
ation branch of Trusted Services. The changes were validated both with the up=
-stream SPMC part of OP-TEE v3.17 and the forked version available at tf.org.

TLDR;
As you may already know the TS team implemented a POC Linux Kernel driver to =
allow user-space access to the FF-A driver available in the Linux Kernel. Thi=
s driver is based on the DebugFS driver and thus is only feasible for testing=
. There is work ongoing on another implementation based on the TEE driver inf=
rastructure in the Linux Kernel. (See: [1].) All PSA SPs were changed to use =
the TEE driver. The original DebugFS based driver is kept for SmmGW SP testin=
g purposes. (Note: The SmmGW SP is not supported by the up-stream SPMC yet).

For more information, please see the links in the original email.

[1]: https://www.spinics.net/lists/kernel/msg4337467.html

/George

-----Original Message-----
From: Balint Dobszay <balint.dobszay@arm.com>=20
Sent: 03 May 2022 16:09
To: op-tee(a)lists.trustedfirmware.org; trusted-services(a)lists.trustedfirmw=
are.org
Cc: nd <nd@arm.com>
Subject: OP-TEE v3.17 S-EL1 SPMC status

Hi All,

This is a follow-up email to the OP-TEE v3.17 release, highlighting the updat=
es to the SPMC component. As you might know there is a forked version living =
at [1], and we are continuously working on moving all features to upstream.

This version enables all PSA Secure Partitions implemented by Trusted Service=
s to work with the upstream SPMC. For more information about the PSA SPs, ple=
ase see [2].

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

If you have any questions, please do not hesitate to reach out to us via [5] =
or [6].

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

--===============7818311651335178566==--


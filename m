From: Jacob Kroon <Jacob.Kroon@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: Conflict with "fallthrough" define
Date: Wed, 02 Apr 2025 18:20:38 +0000
Message-ID: <GV2PR02MB8920DD8FE701332DC2B7FE098AAF2@GV2PR02MB8920.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7696407357506895879=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7696407357506895879==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We are using OP-TEE together with a library that provides its own "fallthroug=
h" define, similar to what OP-TEE does in lib/libutils/ext/include/compiler.h:

#define fallthrough __attribute__((__fallthrough__))

However, this other library checks for fallthrough attribute support by first=
 doing:

#if __has_cpp_attribute(fallthrough)
...
#endif

which fails to compile due to the OP-TEE define.

Would OP-TEE accept a patch to rename the "fallthrough" define to something l=
ike "optee_fallthrough", "FALLTHROUGH", <other suggestion> ?

Or should we upstream a patch to the library to do:

#if __has_cpp_attribute(__fallthrough__)
...
#endif

(which is what OP-TEE currently does)

Regards
Jacob

--===============7696407357506895879==--


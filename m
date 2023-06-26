From: haiyuan.ghy@alibaba-inc.com
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: optee_benchmark found optee_os function vm_set_ctx() spent much time
Date: Mon, 26 Jun 2023 08:38:58 +0000
Message-ID: <168776873876.1165.5832647553655830437@lists.trustedfirmware.org>
In-Reply-To: <
 <CAHUa44FUqg-1fnMDRyUX7AtO8A0S_8KGbRK231n=vp4s0q4ePg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0580288401514410086=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0580288401514410086==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jens,
I tried CFG_CORE_PREALLOC_EL0_TBLS=3Dy to compile optee_os.
I used the same optee_example_hello_world CA and TA, tested 10K times InvokeC=
ommand.
I got average of time was 17 us, somewhat less than previous 20 us.

Any suggestion? Thanks for help.

--===============0580288401514410086==--


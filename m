From: Jan Claußen <jan.claussen10@web.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Why are there to stripped.elf for optee_test_lib and
 optee_test_lib_dl TAs?
Date: Wed, 17 Jan 2024 15:43:25 +0100
Message-ID: <395C0752-83EE-4C27-8888-ECCAEDC1BF15@getmailspring.com>
In-Reply-To: <4FE5F245-8FB7-4F9A-960C-195EAEDE189B@getmailspring.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0747163570876658009=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0747163570876658009==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I meant the os_test_lib and os_test_lib_dl!

Upon inspection there are stripped.so files for these libraries. So I assume =
that the libraries need to somehow be signed and packaged to a TA as well. Th=
is case doesn't seem to be covered in the documentation though, so it is not =
clear to me how to do that.

--===============0747163570876658009==--


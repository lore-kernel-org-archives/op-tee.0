From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Calling tee_invoke_supp_plugin_rpc() with exceptions masked
Date: Fri, 05 May 2023 14:07:31 +0200
Message-ID: 
 <CAHUa44G3h4UAufeqdVGShVk0Dw_Cg76sEDDC5thKXuWS02o7VA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CAM9PR02MB6657B4124C92DBBC65AD6B268A729=40AM9PR02MB?=
 =?utf-8?q?6657=2Eeurprd02=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4447883905915981151=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4447883905915981151==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacob,

On Fri, May 5, 2023 at 2:01=E2=80=AFPM Jacob Kroon <Jacob.Kroon@axis.com> w=
rote:
>
> Hi,
>
> I'm wondering if it is safe to call tee_invoke_supp_plugin_rpc() from withi=
n the OP-TEE kernel with both foreign and/or native exceptions masked ?

tee_invoke_supp_plugin_rpc() must be called from a normal thread
context, the exceptions can be masked even if it's probably not a good
idea.

Cheers,
Jens

--===============4447883905915981151==--


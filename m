From: Jacob Kroon <Jacob.Kroon@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Calling tee_invoke_supp_plugin_rpc() with exceptions masked
Date: Fri, 05 May 2023 12:25:00 +0000
Message-ID: <AM9PR02MB6657F920ACC0CC101AC466678A729@AM9PR02MB6657.eurprd02.prod.outlook.com>
In-Reply-To: <
 <CAHUa44G3h4UAufeqdVGShVk0Dw_Cg76sEDDC5thKXuWS02o7VA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1048462985872790133=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1048462985872790133==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Ok, thank you.

Regards,
Jacob

________________________________________
From: Jens Wiklander <jens.wiklander@linaro.org>
Sent: Friday, May 5, 2023 2:07 PM
To: Jacob Kroon
Cc: op-tee(a)lists.trustedfirmware.org; Lars Persson
Subject: Re: Calling tee_invoke_supp_plugin_rpc() with exceptions masked

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

--===============1048462985872790133==--


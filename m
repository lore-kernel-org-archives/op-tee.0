From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Calling tee_invoke_supp_plugin_rpc() with exceptions masked
Date: Fri, 05 May 2023 18:25:51 +0530
Message-ID: 
 <CAFA6WYM__YBNt_8nJz99Muxt9wai9g3Ma5QpqN=WN2hsWDwS=g@mail.gmail.com>
In-Reply-To: <
 <CAHUa44G3h4UAufeqdVGShVk0Dw_Cg76sEDDC5thKXuWS02o7VA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6362478662199866025=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6362478662199866025==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 May 2023 at 17:37, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> Hi Jacob,
>
> On Fri, May 5, 2023 at 2:01=E2=80=AFPM Jacob Kroon <Jacob.Kroon@axis.com>=
 wrote:
> >
> > Hi,
> >
> > I'm wondering if it is safe to call tee_invoke_supp_plugin_rpc() from wit=
hin the OP-TEE kernel with both foreign and/or native exceptions masked ?
>
> tee_invoke_supp_plugin_rpc() must be called from a normal thread
> context, the exceptions can be masked even if it's probably not a good
> idea.

Yeah, especially if expensive operations are performed by that RPC
with interrupts masked, you are probably going to get CPU stall
messages from the Linux scheduler.

-Sumit

>
> Cheers,
> Jens

--===============6362478662199866025==--


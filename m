From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 061/141] tee: Fix fall-through warnings for Clang
Date: Mon, 17 May 2021 18:43:17 -0500
Message-ID: <aabd24b1-fe72-946d-c9f4-dea5e5db40db@embeddedor.com>
In-Reply-To: <e44a9011-f2ed-f1d2-cc1a-7dcba2f41956@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3173746367390575372=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3173746367390575372==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 4/20/21 15:20, Gustavo A. R. Silva wrote:
> Hi all,
>=20
> Friendly ping: who can take this, please?
>=20
> Thanks
> --
> Gustavo
>=20
> On 11/23/20 16:55, Gustavo A. R. Silva wrote:
>> On Sun, Nov 22, 2020 at 10:26:09AM +0100, Jens Wiklander wrote:
>>> On Fri, Nov 20, 2020 at 7:33 PM Gustavo A. R. Silva
>>> <gustavoars@kernel.org> wrote:
>>>>
>>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>>>> by explicitly adding a break statement instead of letting the code fall
>>>> through to the next case.
>>>>
>>>> Link: https://github.com/KSPP/linux/issues/115
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>>  drivers/tee/tee_core.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>
>>> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

I've added this to my -next[1] branch for v5.14.

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/=
?h=3Dfor-next/kspp

--===============3173746367390575372==--


From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3] optee: add timeout value to optee_notif_wait() to
 support timeout
Date: Fri, 31 May 2024 08:55:58 +0200
Message-ID: 
 <CAHUa44Hpfq+6qsuZ9NYUB55br=5H0Bi1p7ALoAY3Cad5egOcdg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNRVa_oem2TdyjoaUOTmW+vED-7LOC4wFjqG+puptg8tQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6344720686049697979=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6344720686049697979==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:35=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 21 May 2024 at 14:16, Gavin Liu (=E5=8A=89=E5=93=B2=E5=BB=B7) <Gavi=
n.Liu@mediatek.com> wrote:
> >
> > Hi, Sumit,
> >
> > The corresponding OPTEE-OS pull request and change is here.
> >
> > https://github.com/OP-TEE/optee_os/pull/6641
>
> As this is an ABI change where I see backwards compatibility is
> maintained. However, the forwards compatibility requires this change
> to be backported to stable releases. So for the next version please CC
> stable ML.
>
> >
> > On Mon, 2024-05-20 at 16:16 +0530, Sumit Garg wrote:
> > >
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > >  Hi,
> > >
> > > On Tue, 7 May 2024 at 07:31, gavin.liu <gavin.liu@mediatek.com>
> > > wrote:
> > > >
> > > > From: Gavin Liu <gavin.liu@mediatek.com>
> > > >
> > > > Add timeout value to support self waking when timeout to avoid
> > > waiting
> > > > indefinitely.
> > > >
> > > > Signed-off-by: Gavin Liu <gavin.liu@mediatek.com>
> > > > ---
> > > > change in v3:
> > > > 1. change the comment in optee_rpc_cmd.h
> > > > 2. add macro for "TEE_ERROR_TIMEOUT"
> > > > 3. change from "TEEC_ERROR_BUSY" to "TEE_ERROR_TIMEOUT"
> > > > ---
> > > >  drivers/tee/optee/notif.c         |  9 +++++++--
> > > >  drivers/tee/optee/optee_private.h |  5 ++++-
> > > >  drivers/tee/optee/optee_rpc_cmd.h |  1 +
> > > >  drivers/tee/optee/rpc.c           | 10 ++++++++--
> > > >  4 files changed, 20 insertions(+), 5 deletions(-)
> > > >
>
> FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

--===============6344720686049697979==--


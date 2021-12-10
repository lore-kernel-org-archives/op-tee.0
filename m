From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Date: Fri, 10 Dec 2021 10:43:50 +0100
Message-ID: 
 <CAN5uoS-Ho-YVY8N_3ouW2zaeVMvBTquLV12cgJbM4nTwtZTDfg@mail.gmail.com>
In-Reply-To: <
 <CAN5uoS9xv-kKpC4E6-muYdh59g8XPSDfbquk5=DbQ4GmiVk-PA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2532935437635030231=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2532935437635030231==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

fixing typos :(


On Fri, 10 Dec 2021 at 10:38, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
> On Fri, 10 Dec 2021 at 09:10, Jerome Forissier <jerome@forissier.org> wro=
te:
> > +CC Jens, Etienne
> > On 12/10/21 06:00, Sumit Garg wrote:
> > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.c=
om> wrote:
> > >> From: Sumit Garg <sumit.garg@linaro.org>
> > >> Sent: Thursday, December 9, 2021 7:41 PM
> > > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > > with tee-supplicant. So once the communication is done, the underlying
> > > shared memory should be freed. I can't think of any scenario where
> > > optee-os should keep hold-off shared memory indefinitely.
> >
> > I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> > the config file [1] and the commit which introduced this config [2].
> >
> > [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
> > [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
>
> (snip)
>
> It's been a while since OP-TEE caches some shm buffers to prevent
> re-allocting them on and on.
> OP-TEE does so for 1 shm buffer per "tee threads" OP-TEE has provisioned.
> Each thread can cache a shm reference.
> Note that used RPCs from optee to linux/u-boot/ree do not require such
> message buffer (IMO).

I meant: "Note that **most of the** used RPCs from ..."

br,
etienne

--===============2532935437635030231==--


From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4 08/10] KEYS: trusted: tee: use tee_shm_register_kernel_buf()
Date: Mon, 21 Feb 2022 02:52:56 +0100
Message-ID: <YhLweBhnmITyErqG@kernel.org>
In-Reply-To: <
 <CAHUa44HkQtstCyUt_J962rzysFnOJOP+e3T2gL7nV+6V5hfa9A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0618091341985422918=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0618091341985422918==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Feb 09, 2022 at 03:08:48PM +0100, Jens Wiklander wrote:
> Hi Jarkko,
> 
> On Fri, Feb 4, 2022 at 10:34 AM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > Uses the new simplified tee_shm_register_kernel_buf() function instead
> > of the old tee_shm_alloc() function which required specific
> > TEE_SHM-flags
> >
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  security/keys/trusted-keys/trusted_tee.c | 23 +++++++++--------------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> Since this patch depends on other patches in this patch set and vice
> versa is it OK if I take this patch via my tree? I'm aiming for v5.18
> with this.

Yes.

You can also add:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

--===============0618091341985422918==--


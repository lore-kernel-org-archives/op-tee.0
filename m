From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v13 4/7] remoteproc: Introduce release_fw optional operation
Date: Thu, 21 Nov 2024 08:54:14 -0700
Message-ID: 
 <CANLsYkx-dpMvYwQN3XgbPS6xQ9Vv6smP1krNYTYpBzdbBJjCrQ@mail.gmail.com>
In-Reply-To: <57a66f3c-d644-4ebb-b4dd-0b9d411ec243@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0926778220418907615=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0926778220418907615==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Nov 2024 at 09:39, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
>
>
> On 11/20/24 17:04, Mathieu Poirier wrote:
> > On Tue, 19 Nov 2024 at 13:38, Mathieu Poirier
> > <mathieu.poirier@linaro.org> wrote:
> >>
> >> On Tue, 19 Nov 2024 at 11:14, Arnaud POULIQUEN
> >> <arnaud.pouliquen@foss.st.com> wrote:
> >>>
> >>> Hello Mathieu,
> >>>
> >>> On 11/18/24 18:52, Mathieu Poirier wrote:
> >>>> On Mon, Nov 04, 2024 at 02:35:12PM +0100, Arnaud Pouliquen wrote:
> >>>>> This patch updates the rproc_ops struct to include an optional
> >>>>> release_fw function.
> >>>>>
> >>>>> The release_fw ops is responsible for releasing the remote processor
> >>>>> firmware image. The ops is called in the following cases:
> >>>>>
> >>>>>  - An error occurs in rproc_start() between the loading of the segmen=
ts and
> >>>>>       the start of the remote processor.
> >>>>>  - after stopping the remote processor.
> >>>>>
> >>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >>>>> ---
> >>>>> Updates from version V11:
> >>>>> - fix typo in @release_fw comment
> >>>>> ---
> >>>>>  drivers/remoteproc/remoteproc_core.c | 5 +++++
> >>>>>  include/linux/remoteproc.h           | 3 +++
> >>>>>  2 files changed, 8 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remotepro=
c/remoteproc_core.c
> >>>>> index 7694817f25d4..46863e1ca307 100644
> >>>>> --- a/drivers/remoteproc/remoteproc_core.c
> >>>>> +++ b/drivers/remoteproc/remoteproc_core.c
> >>>>> @@ -1258,6 +1258,9 @@ static int rproc_alloc_registered_carveouts(str=
uct rproc *rproc)
> >>>>>
> >>>>>  static void rproc_release_fw(struct rproc *rproc)
> >>>>>  {
> >>>>> +    if (rproc->ops->release_fw)
> >>>>> +            rproc->ops->release_fw(rproc);
> >>>>> +
> >>>>>      /* Free the copy of the resource table */
> >>>>>      kfree(rproc->cached_table);
> >>>>>      rproc->cached_table =3D NULL;
> >>>>> @@ -1377,6 +1380,8 @@ static int rproc_start(struct rproc *rproc, con=
st struct firmware *fw)
> >>>>>  unprepare_subdevices:
> >>>>>      rproc_unprepare_subdevices(rproc);
> >>>>>  reset_table_ptr:
> >>>>> +    if (rproc->ops->release_fw)
> >>>>> +            rproc->ops->release_fw(rproc);
> >>>>>      rproc->table_ptr =3D rproc->cached_table;
> >>>>
> >>>> I suggest the following:
> >>>>
> >>>> 1) Create two new functions, i.e rproc_load_fw() and rproc_release_fw(=
).  The
> >>>> only thing those would do is call rproc->ops->load_fw() and
> >>>> rproc->ops->release_fw(), if they are present.  When a TEE interface is
> >>>> available, ->load_fw() and ->release_fw() become rproc_tee_load_fw() a=
nd
> >>>> rproc_tee_release_fw().
> >>>
> >>>
> >>> I'm wondering if it should be ->preload_fw() instead of ->load_fw() ops=
, as the
> >>> ->load() op already exists.
> >>>
> >>
> >> I agree that ->load() and ->load_fw() will lead to confusion.  I would
> >> support ->preload_fw() but there is no obvious antonyme.
> >>
> >> Since we already have rproc_ops::prepare() and rproc_prepare_device()
> >> I suggest rproc_ops::prepare_fw() and rproc_prepare_fw().  The
> >> corollary would be rproc_ops::unprepare_fw() and rproc_unprepare_fm().
> >> That said, I'm open to other ideas should you be interested in finding
> >> other alternatives.
> >>
> >
> > Actually...  A better approach might to rename rproc::load to
> > rproc::load_segments.  That way we can use rproc::load_fw() and
> > rproc_load_fw() without confusion.
>
> Concerning this proposal, please correct me if I'm wrong
> - ops::load_segments() would be used for ELF format only as segment notion =
seems
> linked to this format.

Correct - nothing different from what it is now.

> - ops:rproc_load_fw should be used for other formats.
>
> The risk is that someone may later come with a requirement to get a resource
> table first to configure some memories before loading a non-ELF firmware.
>

We can address that problem if/when it comes about.

>
> >
> >>>>
> >>>> 2) Call rproc_load_fw() in rproc_boot(), just before rproc_fw_boot(). =
 If the
> >>>> call to rproc_fw_boot() fails, call rproc_release_fw().
> >>>>
> >>>> 3) The same logic applies to rproc_boot_recovery(), i.e call rproc_loa=
d_fw()
> >>>> before rproc_start() and call rproc_release_fw() if rproc_start() fail=
s.
> >>>
> >>>
> >>> I implemented this and I'm currently testing it.
> >>> Thise second part requires a few adjustments to work. The ->load() ops =
needs to
> >>> becomes optional to not be called if the "->preload_fw()" is used.
> >>>
> >>> For that, I propose to return 0 in rproc_load_segments if rproc->ops->l=
oad is
> >>> NULL and compensate by checking that at least "->preload_fw()" or ->loa=
d() is
> >>> non-null in rproc_alloc_ops.
> >>>
> >>
> >> I agree.
> >>
> >>> Thanks,
> >>> Arnaud
> >>>
> >>>
> >>>>
> >>>> 4) Take rproc_tee_load_fw() out of rproc_tee_parse_fw().  It will now =
be called
> >>>> in rproc_load_fw().
> >>>>
> >>>> 5) As stated above function rproc_release_fw() now calls rproc_tee_rel=
ease_fw().
> >>>> The former is already called in rproc_shutdown() so we are good in tha=
t front.
> >>>>
> >>>> With the above the cached_table management within the core remains the=
 same and
> >>>> we can get rid of patch 3.7.
> >>>
> >>>>
> >>>> Thanks,
> >>>> Mathieu
> >>>>
> >>>>>
> >>>>>      return ret;
> >>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> >>>>> index 2e0ddcb2d792..08e0187a84d9 100644
> >>>>> --- a/include/linux/remoteproc.h
> >>>>> +++ b/include/linux/remoteproc.h
> >>>>> @@ -381,6 +381,8 @@ enum rsc_handling_status {
> >>>>>   * @panic:  optional callback to react to system panic, core will de=
lay
> >>>>>   *          panic at least the returned number of milliseconds
> >>>>>   * @coredump:         collect firmware dump after the subsystem is s=
hutdown
> >>>>> + * @release_fw:     optional function to release the firmware image =
from ROM memories.
> >>>>> + *          This function is called after stopping the remote proces=
sor or in case of an error
> >>>>>   */
> >>>>>  struct rproc_ops {
> >>>>>      int (*prepare)(struct rproc *rproc);
> >>>>> @@ -403,6 +405,7 @@ struct rproc_ops {
> >>>>>      u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware =
*fw);
> >>>>>      unsigned long (*panic)(struct rproc *rproc);
> >>>>>      void (*coredump)(struct rproc *rproc);
> >>>>> +    void (*release_fw)(struct rproc *rproc);
> >>>>>  };
> >>>>>
> >>>>>  /**
> >>>>> --
> >>>>> 2.25.1
> >>>>>

--===============0926778220418907615==--


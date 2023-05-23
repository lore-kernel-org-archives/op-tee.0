From: John Hubbard <jhubbard@nvidia.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
Date: Mon, 22 May 2023 18:54:29 -0700
Message-ID: <1ced7f32-553e-2a5b-eec9-f794d7983d56@nvidia.com>
In-Reply-To: <8b898768-a3c0-198d-a70c-9aa96b7f4a29@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0530130134263687162=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0530130134263687162==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 5/18/23 06:56, David Hildenbrand wrote:
> On 18.05.23 08:08, Sumit Garg wrote:
>> On Thu, 18 May 2023 at 09:51, Christoph Hellwig <hch@infradead.org> wrot=
e:
>>>
>>> On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
>>>> In general: if user space controls it -> possibly forever -> long-term. =
Even
>>>> if in most cases it's a short delay: there is no trusting on user space.
>>>>
>>>> For example, iouring fixed buffers keep pages pinned until user space
>>>> decides to unregistered the buffers -> long-term.
>>>>
>>>> Short-term is, for example, something like O_DIRECT where we pin -> DMA =
->
>>>> unpin in essentially one operation.
>>>
>>> Btw, one thing that's been on my mind is that I think we got the
>>> polarity on FOLL_LONGTERM wrong.=C2=A0 Instead of opting into the long te=
rm
>>> behavior it really should be the default, with a FOLL_EPHEMERAL flag
>>> to opt out of it.=C2=A0 And every users of this flag is required to have
>>> a comment explaining the life time rules for the pin..

I see maybe 10 or 20 call sites today. So it is definitely feasible to add
documentation at each, explaining the why it wants a long term pin.

>>
>> It does look like a better approach to me given the very nature of
>> user space pages.
>=20
> Yeah, there is a lot of historical baggage. For example, FOLL_GET should be=
 inaccessible to kernel modules completely at one point, to be only used by s=
elected core-mm pieces.

Yes. When I first mass-converted call sites from gup to pup, I just
preserved FOLL_GET behavior in order to keep from changing too much at
once. But I agree that that it would be nice to make FOLL_GET an
mm internal-only flag like FOLL_PIN.

>=20
> Maybe we should even disallow passing in FOLL_LONGTERM as a flag and only p=
rovide functions like pin_user_pages() vs. pin_user_pages_longterm(). Then, d=
iscussions about conditional flag-setting are no more :)
>=20
> ... or even use pin_user_pages_shortterm() vs. pin_user_pages() ... to make=
 the default be longterm.
>=20

Yes, it is true that having most gup flags be internal to mm does tend
to avoid some bugs. But it's also a lot of churn. I'm still on the fence
as to whether it's really a good move to do this for FOLL_LONGTERM or
not. But it's really easy to push me off of fences. :)

thanks,
--=20
John Hubbard
NVIDIA


--===============0530130134263687162==--


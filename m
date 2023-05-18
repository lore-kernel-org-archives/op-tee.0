From: David Hildenbrand <david@redhat.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
Date: Thu, 18 May 2023 15:56:09 +0200
Message-ID: <8b898768-a3c0-198d-a70c-9aa96b7f4a29@redhat.com>
In-Reply-To: <
 <CAFA6WYPgvifYcj_MT7BBcC0BtQDWXV0u+HY8qv0M9nNyiCgkow@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3702104188848386745=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3702104188848386745==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 18.05.23 08:08, Sumit Garg wrote:
> On Thu, 18 May 2023 at 09:51, Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
>>> In general: if user space controls it -> possibly forever -> long-term. E=
ven
>>> if in most cases it's a short delay: there is no trusting on user space.
>>>
>>> For example, iouring fixed buffers keep pages pinned until user space
>>> decides to unregistered the buffers -> long-term.
>>>
>>> Short-term is, for example, something like O_DIRECT where we pin -> DMA ->
>>> unpin in essentially one operation.
>>
>> Btw, one thing that's been on my mind is that I think we got the
>> polarity on FOLL_LONGTERM wrong.  Instead of opting into the long term
>> behavior it really should be the default, with a FOLL_EPHEMERAL flag
>> to opt out of it.  And every users of this flag is required to have
>> a comment explaining the life time rules for the pin..
>=20
> It does look like a better approach to me given the very nature of
> user space pages.

Yeah, there is a lot of historical baggage. For example, FOLL_GET should=20
be inaccessible to kernel modules completely at one point, to be only=20
used by selected core-mm pieces.

Maybe we should even disallow passing in FOLL_LONGTERM as a flag and=20
only provide functions like pin_user_pages() vs.=20
pin_user_pages_longterm(). Then, discussions about conditional=20
flag-setting are no more :)

... or even use pin_user_pages_shortterm() vs. pin_user_pages() ... to=20
make the default be longterm.

--=20
Thanks,

David / dhildenb


--===============3702104188848386745==--


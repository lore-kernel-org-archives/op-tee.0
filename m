From: Linus Torvalds <torvalds@linux-foundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
Date: Sat, 04 Feb 2023 19:51:01 +0000
Message-ID: 
 <CAHk-=wiN3fPUDpiZBt+d_p1nncTnBEqmm_xqEa0soL-90Wdsrg@mail.gmail.com>
In-Reply-To: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7127621988356457910=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7127621988356457910==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 3, 2023 at 8:06 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> This series also fixes is_kmap_addr() and uses it to ensure no kmap address=
es
> slip in later.

Ack. Please make it so.

That said...

I wasn't cc'd on all the patches, but checked them on the mailing
list, and that first is_kmap_addr() patch makes me a bit unhappy.

Right now that 'is_kmap_addr()' is only used for user copy addresses,
for debugging purposes, and I'm not exactly thrilled about extending
it this way.

I get the feeling that we should just have a name for that "kmap _or_
kmap_local" range instead of making it two ranges.

But admittedly I can't come up with anything better, and it looks like
different architectures may do different things.  I just don't like
it.

                Linus

--===============7127621988356457910==--


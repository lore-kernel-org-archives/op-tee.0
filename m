From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
Date: Fri, 13 Sep 2024 12:29:35 +0300
Message-ID: <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
In-Reply-To: <
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2350273322634917282=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2350273322634917282==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
> On Wed, Sep 11, 2024 at 10:41 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Replace the custom approach with the %pUl printk() format specifier.
> > No functional change intended.

> Thanks, the patch looks like a nice simplificatrion.

Thank you for the review.

> Rijo, Devaraj, does this work for you?

Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
but in this driver IIUC it's guid_t (UUID LE).

-- 
With Best Regards,
Andy Shevchenko



--===============2350273322634917282==--


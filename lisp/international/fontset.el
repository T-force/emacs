;;; fontset.el --- commands for handling fontset

;; Copyright (C) 1995, 1997 Electrotechnical Laboratory, JAPAN.
;; Licensed to the Free Software Foundation.
;; Copyright (C) 2001 Free Software Foundation, Inc.

;; Keywords: mule, i18n, fontset

;; This file is part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;; Code:

;; Setup font-encoding-alist for all known encodings.

(setq font-encoding-alist
      '(("iso8859-1$" . iso-8859-1)
	("iso8859-2$" . iso-8859-2)
	("iso8859-3$" . iso-8859-3)
	("iso8859-4$" . iso-8859-4)
	("iso8859-5$" . iso-8859-5)
	("iso8859-6$" . iso-8859-6)
	("iso8859-7$" . iso-8859-7)
	("iso8859-8$" . iso-8859-8)
	("iso8859-9$" . iso-8859-9)
	("iso8859-10$" . iso-8859-10)
	("iso8859-11$" . iso-8859-11)
	("iso8859-13$" . iso-8859-13)
	("iso8859-14$" . iso-8859-14)
	("iso8859-15$" . iso-8859-15)
	("gb2312.1980" . chinese-gb2312)
	("jisx0208.1978" . japanese-jisx0208-1978)
	("jisx0208" . japanese-jisx0208)
	("jisx0201" . jisx0201)
	("jisx0212" . japanese-jisx0212)
	("ksc5601.1987" . korean-ksc5601)
	("cns11643.1992.*1" . chinese-cns11643-1)
	("cns11643.1992.*2" . chinese-cns11643-2)
	("cns11643.1992.*3" . chinese-cns11643-3)
	("cns11643.1992.*4" . chinese-cns11643-4)
	("cns11643.1992.*5" . chinese-cns11643-5)
	("cns11643.1992.*6" . chinese-cns11643-6)
	("cns11643.1992.*7" . chinese-cns11643-7)
	("big5" . big5)
	("sisheng_cwnn" . chinese-sisheng)
	("viscii" . viscii)
	("tis620" . tis620-2533)
	("mulearabic-0" . arabic-digit)
	("mulearabic-1" . arabic-1-column)
	("mulearabic-2" . arabic-2-column)
	("muleipa" . ipa)
	("ethiopic-unicode" . ethiopic)
	("is13194-devanagari" . indian-is13194)
	("devanagari-cdac" . devanagari-glyph)
;; These would be necessary for supporting the complete set of Indian
;; scripts.  See also mule-conf.el.
;; 	("sanskrit-cdac" . sanskrit-glyph)
;; 	("bengali-cdac" . bengali-glyph)
;; 	("assamese-cdac" . assamese-glyph)
;; 	("punjabi-cdac" . punjabi-glyph)
;; 	("gujarati-cdac" . gujarati-glyph)
;; 	("oriya-cdac" . oriya-glyph)
;; 	("tamil-cdac" . tamil-glyph)
;; 	("telugu-cdac" . telugu-glyph)
;; 	("kannada-cdac" . kannada-glyph)
;; 	("malayalam-cdac" . malayalam-glyph)
	("muleindian-2" . indian-2-column)
	("muleindian-1" . indian-1-column)
	("mulelao-1" . mule-lao)
	("muletibetan-2" . tibetan)
	("muletibetan-1" . tibetan-1-column)
	("jisx0213.2000-1" . japanese-jisx0213-1)
	("jisx0213.2000-2" . japanese-jisx0213-2)
	("abobe-symbol" . symbol)
	("iso10646-1" . (unicode . nil))
	("iso10646.indian-1" . (unicode . nil))))


;; Set standard fontname specification of characters in the default
;; fontset to find an appropriate font for each script/charset.  The
;; specification has the form ((SCRIPT FONT-SPEC ...) ...), where
;; FONT-SPEC is:
;;	a vector [ FAMILY WEIGHT SLANT ADSTYLE REGISTRY ],
;;	or a cons (FAMILY . REGISTRY),
;;	or a string FONT-NAME.
;; 
;; FAMILY, WEIGHT, SLANT, and ADSTYLE may be nil, in which case, the
;; the corresponding name of default face is used.  If REGISTRY
;; contains a character `-', the string before that is embedded in
;; `CHARSET_REGISTRY' field, and the string after that is embedded in
;; `CHARSET_ENCODING' field.  If it does not contain `-', the whole
;; string is embedded in `CHARSET_REGISTRY' field, and a wild card
;; character `*' is embedded in `CHARSET_ENCODING' field.
;;
;; SCRIPT is a symbol that appears as an element of the char table
;; `char-script-table'.  SCRIPT may be a charset specifying the range
;; of characters.

(new-fontset
 "fontset-default"
 '( ;; for each script
   (latin (nil . "ISO8859-1")
	  (nil . "ISO8859-2")
	  (nil . "ISO8859-3")
	  (nil . "ISO8859-4")
	  (nil . "ISO8859-9")
	  (nil . "ISO8859-10")
	  (nil . "ISO8859-13")
	  (nil . "ISO8859-14")
	  (nil . "ISO8859-15")
	  (nil . "VISCII1.1-1"))

   (thai (nil . "TIS620*")
	 (nil . "ISO8859-11"))

   (devanagari (nil . "iso10646.indian-1"))

   (lao  (nil . "MuleLao-1"))

   ;; both for script and charset.
   (tibetan (nil . "muletibetan-2"))

   ;; both for script and charset.
   (ethiopic (nil . "ethiopic-unicode"))

   (greek (nil . "ISO8859-7"))

   (cyrillic (nil . "ISO8859-5"))

   (arabic (nil . "MuleArabic-0")
	   (nil . "MuleArabic-1")
	   (nil . "MuleArabic-2")
	   (nil . "ISO8859-6"))

   (hebrew (nil . "ISO8859-8"))

   (kana (nil . "JISX0208*")
	 (nil . "GB2312.1980-0")
	 (nil . "KSC5601.1987*")
	 (nil . "JISX0201*"))

   (bopomofo (nil . "sisheng_cwnn-0"))

   (han (nil . "GB2312.1980-0")
	(nil . "JISX0208*")
	(nil . "JISX0212*")
	(nil . "big5*")
	(nil . "KSC5601.1987*")
	(nil . "CNS11643.1992-1")
	(nil . "CNS11643.1992-2")
	(nil . "CNS11643.1992-3")
	(nil . "CNS11643.1992-4")
	(nil . "CNS11643.1992-5")
	(nil . "CNS11643.1992-6")
	(nil . "CNS11643.1992-7")
	(nil . "gbk-0")
	(nil . "JISX0213.2000-1")
	(nil . "JISX0213.2000-2"))

   (cjk-misc (nil . "GB2312.1980-0")
	     (nil . "JISX0208*")
	     (nil . "JISX0212*")
	     (nil . "big5*")
	     (nil . "KSC5601.1987*")
	     (nil . "CNS11643.1992-1")
	     (nil . "CNS11643.1992-2")
	     (nil . "CNS11643.1992-3")
	     (nil . "CNS11643.1992-4")
	     (nil . "CNS11643.1992-5")
	     (nil . "CNS11643.1992-6")
	     (nil . "CNS11643.1992-7")
	     (nil . "gbk-0")
	     (nil . "JISX0213.2000-1")
	     (nil . "JISX0213.2000-2"))

   (hangul (nil . "KSC5601.1987-0"))

   ;; for each charset
   (ascii (nil . "ISO8859-1"))
   (arabic-digit ("*" . "MuleArabic-0"))
   (arabic-1-column ("*" . "MuleArabic-1"))
   (arabic-2-column ("*" . "MuleArabic-2"))
   (indian-is13194 (nil . "is13194-devanagari"))
   (indian-1-column ("*" . "muleindian-2"))
   (devanagari-glyph ("altsys-dv_ttsurekh" . "devanagari-cdac"))
;; These would be necessary for supporting the complete set of Indian
;; scripts.
   ;; fixme: family name
;;    (sanskrit-glyph ("*" . "sanskrit-cdac"))
;;    (bengali-glyph ("*" . "bengali-cdac"))
;;    (assamese-glyph ("*" . "assamese-cdac"))
;;    (punjabi-glyph ("*" . "punjabi-cdac"))
;;    (gujarati-glyph ("*" . "gujarati-cdac"))
;;    (oriya-glyph ("*" . "oriya-cdac"))
;;    (tamil-glyph ("*" . "tamil-cdac"))
;;    (telugu-glyph ("*" . "telugu-cdac"))
;;    (kannada-glyph ("*" . "kannada-cdac"))
   (malayalam-glyph ("altsys-ml_ttkarthika" . "malayalam-cdac"))
   (ipa (nil . "MuleIPA-1"))
   ))

;; Append Unicode fonts.
;; This may find fonts with more variants (bold, italic) but which don't cover
;; many characters.
(set-fontset-font "fontset-default" '(#x00A0 . #xFFFF)
		  '(nil . "iso10646-1") nil 'append)
;; These may find fonts that cover many characters but with fewer variants.
(set-fontset-font "fontset-default" '(#x00A0 . #xFFFF)
		  '("gnu-unifont" . "iso10646-1") nil 'append)
(set-fontset-font "fontset-default" '(#x00A0 . #xFFFF)
		  '("mutt-clearlyu" . "iso10646-1") nil 'append)

;; These are the registered registries/encodings from
;; ftp://ftp.x.org/pub/DOCS/registry 2001/06/01

;; Name                                            Reference
;; ----                                            ---------
;; "DEC"                                           [27]
;;         registry prefix
;; "DEC.CNS11643.1986-2"                           [53]
;;         CNS11643 2-plane using the encoding
;;         suggested in that standard
;; "DEC.DTSCS.1990-2"                              [54]
;;         DEC Taiwan Supplemental Character Set
;; "fujitsu.u90x01.1991-0"                         [87]
;; "fujitsu.u90x03.1991-0"                         [87]
;; "GB2312.1980-0"                                 [39],[12]
;;         China (PRC) Hanzi, GL encoding
;; "GB2312.1980-1"                                 [39]
;;         (deprecated)
;;         China (PRC) Hanzi, GR encoding
;; "HP-Arabic8"                                    [36]
;;         HPARABIC8 8-bit character set
;; "HP-East8"                                      [36]
;;         HPEAST8 8-bit character set
;; "HP-Greek8"                                     [36]
;;         HPGREEK8 8-bit character set
;; "HP-Hebrew8"                                    [36]
;;         HPHEBREW8 8-bit character set
;; "HP-Japanese15"                                 [36]
;;         HPJAPAN15 15-bit characer set,
;;         modified from industry defacto
;;         standard Shift-JIS
;; "HP-Kana8"                                      [36]
;;         HPKANA8 8-bit character set
;; "HP-Korean15"                                   [36]
;;         HPKOREAN15 15-bit character set
;; "HP-Roman8"                                     [36]
;;         HPROMAN8 8-bit character set
;; "HP-SChinese15"                                 [36]
;;         HPSCHINA15 15-bit character set for
;;         support of Simplified Chinese
;; "HP-TChinese15"                                 [36]
;;         HPTCHINA15 15-bit character set for
;;         support of Traditional Chinese
;; "HP-Turkish8"                                   [36]
;;         HPTURKISH8 8-bit character set
;; "IPSYS"                                         [59]
;;         registry prefix
;; "IPSYS.IE-1"                                    [59]
;; "ISO2022"<REG>"-"<ENC>                          [44]
;; "ISO646.1991-IRV"                               [107]
;;         ISO 646 International Reference Version
;; "ISO8859-1"                                     [15],[12]
;;         ISO Latin alphabet No. 1
;; "ISO8859-2"                                     [15],[12]
;;         ISO Latin alphabet No. 2
;; "ISO8859-3"                                     [15],[12]
;;         ISO Latin alphabet No. 3
;; "ISO8859-4"                                     [15],[12]
;;         ISO Latin alphabet No. 4
;; "ISO8859-5"                                     [15],[12]
;;         ISO Latin/Cyrillic alphabet
;; "ISO8859-6"                                     [15],[12]
;;         ISO Latin/Arabic alphabet
;; "ISO8859-7"                                     [15],[12]
;;         ISO Latin/Greek alphabet
;; "ISO8859-8"                                     [15],[12]
;;         ISO Latin/Hebrew alphabet
;; "ISO8859-9"                                     [15],[12]
;;         ISO Latin alphabet No. 5
;; "ISO8859-10"                                    [15],[12]
;;         ISO Latin alphabet No. 6
;; "ISO8859-13"                                    [15],[12]
;;         ISO Latin alphabet No. 7
;; "ISO8859-14"                                    [15],[12]
;;         ISO Latin alphabet No. 8
;; "ISO8859-15"                                    [15],[12]
;;         ISO Latin alphabet No. 9
;; "FCD8859-15"                                    [7]
;;         (deprecated)
;;         ISO Latin alphabet No. 9, Final Committee Draft
;; "ISO10646-1"                                    [133]
;;         Unicode Universal Multiple-Octet Coded Character Set
;; "ISO10646-MES"                                  [133]
;;         (deprecated)
;;         Unicode Minimum European Subset
;; "JISX0201.1976-0"                               [38],[12]
;;         8-Bit Alphanumeric-Katakana Code
;; "JISX0208.1983-0"                               [40],[12]
;;         Japanese Graphic Character Set,
;;         GL encoding
;; "JISX0208.1990-0"                               [71]
;;         Japanese Graphic Character Set,
;;         GL encoding
;; "JISX0208.1983-1"                               [40]
;;         (deprecated)
;;         Japanese Graphic Character Set,
;;         GR encoding
;; "JISX0212.1990-0"                               [72]
;;         Supplementary Japanese Graphic Character Set,
;;         GL encoding
;; "KOI8-R"                                        [119]
;;         Cyrillic alphabet
;; "KSC5601.1987-0"                                [41],[12]
;;         Korean Graphic Character Set,
;;         GL encoding
;; "KSC5601.1987-1"                                [41]
;;         (deprecated)
;;         Korean Graphic Character Set,
;;         GR encoding
;; "omron_CNS11643-0"                              [45]
;; "omron_CNS11643-1"                              [45]
;; "omron_BIG5-0"                                  [45]
;; "omron_BIG5-1"                                  [45]
;; "wn.tamil.1993"                                 [103]

(defun set-font-encoding (pattern charset)
  "Set arguments in `font-encoding-alist' (which see)."
  (let ((slot (assoc pattern font-encoding-alist)))
    (if slot
	(setcdr slot charset)
      (setq font-encoding-alist
	    (cons (cons pattern charset) font-encoding-alist)))))

;; Setting for suppressing XLoadQueryFont on big fonts.
(setq x-pixel-size-width-font-regexp
      "gb2312\\|jisx0208\\|ksc5601\\|cns11643\\|big5")

;; These fonts require vertical centering.
(setq vertical-centering-font-regexp
      "gb2312\\|jisx0208\\|jisx0212\\|ksc5601\\|cns11643\\|big5")

;; We must adjust the size of these fonts.
(setq face-resizing-fonts '(("-cdac$" . 1.3)))


(defvar x-font-name-charset-alist nil
  "This variable has no meaning now.  Just kept for backward compatibility.")

;;; XLFD (X Logical Font Description) format handler.

;; Define XLFD's field index numbers.		; field name
(defconst xlfd-regexp-family-subnum 0)		; FOUNDRY and FAMILY
(defconst xlfd-regexp-weight-subnum 1)		; WEIGHT_NAME
(defconst xlfd-regexp-slant-subnum 2)		; SLANT
(defconst xlfd-regexp-swidth-subnum 3)		; SETWIDTH_NAME
(defconst xlfd-regexp-adstyle-subnum 4)		; ADD_STYLE_NAME
(defconst xlfd-regexp-pixelsize-subnum 5)	; PIXEL_SIZE
(defconst xlfd-regexp-pointsize-subnum 6)	; POINT_SIZE
(defconst xlfd-regexp-resx-subnum 7)		; RESOLUTION_X
(defconst xlfd-regexp-resy-subnum 8)		; RESOLUTION_Y
(defconst xlfd-regexp-spacing-subnum 8)		; SPACING
(defconst xlfd-regexp-avgwidth-subnum 10)	; AVERAGE_WIDTH
(defconst xlfd-regexp-registry-subnum 11)	; REGISTRY and ENCODING

;; Regular expression matching against a fontname which conforms to
;; XLFD (X Logical Font Description).  All fields in XLFD should be
;; not be omitted (but can be a wild card) to be matched.
(defconst xlfd-tight-regexp
  "^\
-\\([^-]*-[^-]*\\)-\\([^-]*\\)-\\([^-]*\\)-\\([^-]*\\)\
-\\([^-]*\\)-\\([^-]*\\)-\\([^-]*\\)-\\([^-]*\\)-\\([^-]*\\)\
-\\([^-]*\\)-\\([^-]*\\)-\\([^-]*-[^-]*\\)$")

;; Regular expression matching against a fontname which conforms to
;; XLFD (X Logical Font Description).  All fields in XLFD from FOUNDRY
;; to ADSTYLE, REGISTRY, and ENCODING should be not be omitted (but
;; can be a wild card) to be matched.
(defconst xlfd-style-regexp
  "^\
-\\([^-]*-[^-]*\\)-\\([^-]*\\)-\\([^-]*\\)-\\([^-]*\\)-\\([^-]*\\)-.*\
-\\([^-]*-[^-]*\\)$")

;; List of field numbers of XLFD whose values are numeric.
(defconst xlfd-regexp-numeric-subnums
  (list xlfd-regexp-pixelsize-subnum	;5
	xlfd-regexp-pointsize-subnum	;6
	xlfd-regexp-resx-subnum		;7
	xlfd-regexp-resy-subnum		;8
	xlfd-regexp-avgwidth-subnum	;10
	))

(defun x-decompose-font-name (pattern)
  "Decompose PATTERN into XLFD fields and return vector of the fields.
The length of the vector is 12.

If PATTERN doesn't conform to XLFD, try to get a full XLFD name from
X server and use the information of the full name to decompose
PATTERN.  If no full XLFD name is gotten, return nil."
  (let (xlfd-fields fontname)
    (if (string-match xlfd-tight-regexp pattern)
	(progn
	  (setq xlfd-fields (make-vector 12 nil))
	  (dotimes (i 12)
	    (aset xlfd-fields i (match-string (1+ i) pattern)))
	  (dotimes (i 12)
	    (if (string-match "^[*-]+$" (aref xlfd-fields i))
		(aset xlfd-fields i nil)))
	  xlfd-fields)
      (setq fontname (condition-case nil
			 (x-resolve-font-name pattern)
		       (error)))
      (if (and fontname
	       (string-match xlfd-tight-regexp fontname))
	  ;; We get a full XLFD name.
	  (let ((len (length pattern))
		(i 0)
		l)
	    ;; Setup xlfd-fields by the full XLFD name.  Each element
	    ;; should be a cons of matched index and matched string.
	    (setq xlfd-fields (make-vector 12 nil))
	    (dotimes (i 12)
	      (aset xlfd-fields i
		    (cons (match-beginning (1+ i))
			  (match-string (1+ i) fontname))))

	    ;; Replace wild cards in PATTERN by regexp codes.
	    (setq i 0)
	    (while (< i len)
	      (let ((ch (aref pattern i)))
		(if (= ch ??)
		    (setq pattern (concat (substring pattern 0 i)
					  "\\(.\\)"
					  (substring pattern (1+ i)))
			  len (+ len 4)
			  i (+ i 4))
		  (if (= ch ?*)
		      (setq pattern (concat (substring pattern 0 i)
					    "\\(.*\\)"
					    (substring pattern (1+ i)))
			    len (+ len 5)
			    i (+ i 5))
		    (setq i (1+ i))))))

	    ;; Set each element of xlfd-fields to proper strings.
	    (if (string-match pattern fontname)
		;; The regular expression PATTERN matches the full XLFD
		;; name.  Set elements that correspond to a wild card
		;; in PATTERN to nil, set the other elements to the
		;; exact strings in PATTERN.
		(let ((l (cdr (cdr (match-data)))))
		  (setq i 0)
		  (while (< i 12)
		    (if (or (null l) (< (car (aref xlfd-fields i)) (car l)))
			(progn
			  (aset xlfd-fields i (cdr (aref xlfd-fields i)))
			  (setq i (1+ i)))
		      (if (< (car (aref xlfd-fields i)) (car (cdr l)))
			  (progn
			    (aset xlfd-fields i nil)
			    (setq i (1+ i)))
			(setq l (cdr (cdr l)))))))
	      ;; Set each element of xlfd-fields to the exact string
	      ;; in the corresponding fields in full XLFD name.
	      (dotimes (i 12)
		(aset xlfd-fields i (cdr (aref xlfd-fields i)))))
	    xlfd-fields)))))

(defun x-compose-font-name (fields &optional reduce)
  "Compose X fontname from FIELDS.
FIELDS is a vector of XLFD fields, the length 12.
If a field is nil, wild-card letter `*' is embedded.
Optional argument REDUCE is always ignored.  It exists just for
backward compatibility."
  (concat "-" (mapconcat (lambda (x) (or x "*")) fields "-")))

(defun x-must-resolve-font-name (xlfd-fields)
  "Like `x-resolve-font-name', but always return a font name.
XLFD-FIELDS is a vector of XLFD (X Logical Font Description) fields.
If no font matching XLFD-FIELDS is available, successively replace
parts of the font name pattern with \"*\" until some font is found.
Value is name of that font."
  (let ((ascii-font nil) (index 0))
    (while (and (null ascii-font) (<= index xlfd-regexp-registry-subnum))
      (let ((pattern (x-compose-font-name xlfd-fields)))
	(condition-case nil
	    (setq ascii-font (x-resolve-font-name pattern))
	  (error
	   (message "Warning: no fonts matching `%s' available" pattern)
	   (aset xlfd-fields index "*")
	   (setq index (1+ index))))))
    (unless ascii-font
      (error "No fonts founds"))
    ascii-font))


(defun x-complement-fontset-spec (xlfd-fields fontlist)
  "Complement FONTLIST for charsets based on XLFD-FIELDS and return it.
XLFD-FIELDS is a vector of XLFD (X Logical Font Description) fields.
FONTLIST is an alist of charsets vs the corresponding font names.

The fonts are complemented as below.

At first, if FONTLIST doesn't specify a font for ASCII charset,
generate a font name for the charset from XLFD-FIELDS, and add that
information to FONTLIST.

Then, replace font names with the corresponding XLFD field vectors
while substituting default field names for wild cards if they match
`xlfd-style-regexp'.  The default field names are decided by
XLFD-FIELDS."
  (let* ((default-spec (vector (aref xlfd-fields xlfd-regexp-family-subnum)
			       (aref xlfd-fields xlfd-regexp-weight-subnum)
			       (aref xlfd-fields xlfd-regexp-slant-subnum)
			       (aref xlfd-fields xlfd-regexp-swidth-subnum)
			       (aref xlfd-fields xlfd-regexp-adstyle-subnum)
			       (aref xlfd-fields xlfd-regexp-registry-subnum)))
	 (slot (assq 'ascii fontlist))
	 (ascii-font (cadr slot))
	 xlfd-ascii)
    (if ascii-font
	(progn
	  (setq ascii-font (x-resolve-font-name ascii-font))
	  (setcar (cdr slot) ascii-font)
	  (setq xlfd-ascii (x-decompose-font-name ascii-font))
	  (dotimes (i 11)
	    (or (aref xlfd-fields i)
		(aset xlfd-fields i (aref xlfd-ascii i)))))
      ;; If font for ASCII is not specified, add it.
      (setq xlfd-ascii (copy-sequence xlfd-fields))
      (aset xlfd-ascii xlfd-regexp-registry-subnum "iso8859-1")
      (setq ascii-font (x-must-resolve-font-name xlfd-ascii))
      (setq fontlist (cons (list 'ascii ascii-font) fontlist)))

    (dolist (elt fontlist)
      (let ((name (cadr elt))
	    font-spec)
	(when (string-match xlfd-style-regexp name)
	  (setq font-spec (make-vector 6 nil))
	  (dotimes (i 6)
	    (aset font-spec i (match-string (1+ i) name)))
	  (dotimes (i 6)
	    (if (string-match "^[*-]+$" (aref font-spec i))
		(aset font-spec i (aref default-spec i))))
	  (setcar (cdr elt) font-spec))))

    fontlist))

(defun fontset-name-p (fontset)
  "Return non-nil if FONTSET is valid as fontset name.
A valid fontset name should conform to XLFD (X Logical Font Description)
with \"fontset\" in `<CHARSET_REGISTRY> field."
  (and (string-match xlfd-tight-regexp fontset)
       (string= (match-string (1+ xlfd-regexp-registry-subnum) fontset)
		"fontset")))

(defun generate-fontset-menu ()
  "Return list to be appended to `x-fixed-font-alist'.
Done when `mouse-set-font' is called."
  (let (l)
    (dolist (fontset (fontset-list))
      (or (string-match "fontset-default$" fontset)
	  (push (list (fontset-plain-name fontset) fontset) l)))
    (cons "Fontset"
	  (sort l #'(lambda (x y) (string< (car x) (car y)))))))

(defun fontset-plain-name (fontset)
  "Return a plain and descriptive name of FONTSET."
  (if (not (setq fontset (query-fontset fontset)))
      (error "Invalid fontset: %s" fontset))
  (let ((xlfd-fields (x-decompose-font-name fontset)))
    (if xlfd-fields
	(let ((family (aref xlfd-fields xlfd-regexp-family-subnum))
	      (weight (aref xlfd-fields xlfd-regexp-weight-subnum))
	      (slant  (aref xlfd-fields xlfd-regexp-slant-subnum))
	      (swidth (aref xlfd-fields xlfd-regexp-swidth-subnum))
	      (size   (aref xlfd-fields xlfd-regexp-pixelsize-subnum))
	      (nickname (aref xlfd-fields xlfd-regexp-registry-subnum))
	      name)
	  (if (not (string-match "^fontset-\\(.*\\)$" nickname))
	      (setq nickname family)
	    (setq nickname (match-string 1 nickname)))
	  (if (and size (> (string-to-int size) 0))
	      (setq name (format "%s: %s-dot" nickname size))
	    (setq name nickname))
	  (and weight
	       (cond ((string-match "^medium$" weight)
		      (setq name (concat name " " "medium")))
		     ((string-match "^bold$\\|^demibold$" weight)
		      (setq name (concat name " " weight)))))
	  (and slant
	       (cond ((string-match "^i$" slant)
		      (setq name (concat name " " "italic")))
		     ((string-match "^o$" slant)
		      (setq name (concat name " " "slant")))
		     ((string-match "^ri$" slant)
		      (setq name (concat name " " "reverse italic")))
		     ((string-match "^ro$" slant)
		      (setq name (concat name " " "reverse slant")))))
	  name)
      fontset)))

(defvar charset-script-alist
  '((ascii . latin)
    (latin-iso8859-1 . latin)
    (latin-iso8859-2 . latin)
    (latin-iso8859-3 . latin)
    (latin-iso8859-4 . latin)
    (latin-iso8859-9 . latin)
    (latin-iso8859-10 . latin)
    (latin-iso8859-13 . latin)
    (latin-iso8859-14 . latin)
    (latin-iso8859-15 . latin)
    (latin-iso8859-16 . latin)
    (latin-jisx0201 . latin)
    (thai-tis620 . thai)
    (cyrillic-iso8859-5 . cyrillic)
    (arabic-iso8859-6 . arabic)
    (greek-iso8859-7 . latin)
    (hebrew-iso8859-8 . latin)
    (katakana-jisx0201 . kana)
    (chinese-gb2312 . han)
    (chinese-big5-1 . han)
    (chinese-big5-2 . han)
    (chinese-cns11643-1 . han)
    (chinese-cns11643-2 . han)
    (chinese-cns11643-3 . han)
    (chinese-cns11643-4 . han)
    (chinese-cns11643-5 . han)
    (chinese-cns11643-6 . han)
    (chinese-cns11643-7 . han)
    (japanese-jisx0208 . han)
    (japanese-jisx0208-1978 . han)
    (japanese-jisx0212 . han)
    (japanese-jisx0213-1 . han)
    (japanese-jisx0213-2 . han)
    (korean-ksc5601 . hangul)
    (chinese-sisheng . bopomofo)
    (vietnamese-viscii-lower . latin)
    (vietnamese-viscii-upper . latin)
    (arabic-digit . arabic)
    (arabic-1-column . arabic)
    (arabic-2-column . arabic)
    (indian-is13194 . devanagari)
    (indian-glyph . devanagari)
    (indian-1-column . devanagari)
    (indian-2-column . devanagari)
    (tibetan-1-column . tibetan))
  "Alist of charsets vs the corresponding most appropriate scripts.

This alist is used by the function `create-fontset-from-fontset-spec'
to map charsets to scripts.")

;;;###autoload
(defun create-fontset-from-fontset-spec (fontset-spec
					 &optional style-variant noerror)
  "Create a fontset from fontset specification string FONTSET-SPEC.
FONTSET-SPEC is a string of the format:
	FONTSET-NAME,SCRIPT-NAME0:FONT-NAME0,SCRIPT-NAME1:FONT-NAME1, ...
Any number of SPACE, TAB, and NEWLINE can be put before and after commas.

Optional 2nd argument is ignored.  It exists just for backward
compatibility.

If this function attempts to create already existing fontset, error is
signaled unless the optional 3rd argument NOERROR is non-nil.

It returns a name of the created fontset.

For backward compatibility, SCRIPT-NAME may be a charset name, in
which case, the corresponding script is decided by the variable
`charset-script-alist' (which see)."
  (if (not (string-match "^[^,]+" fontset-spec))
      (error "Invalid fontset spec: %s" fontset-spec))
  (let ((idx (match-end 0))
	(name (match-string 0 fontset-spec))
	xlfd-fields script fontlist ascii-font)
    (if (query-fontset name)
	(or noerror
	    (error "Fontset \"%s\" already exists" name))
      (setq xlfd-fields (x-decompose-font-name name))
      (or xlfd-fields
	  (error "Fontset \"%s\" not conforming to XLFD" name))

      ;; At first, extract pairs of charset and fontname from FONTSET-SPEC.
      (while (string-match "[, \t\n]*\\([^:]+\\):\\([^,]+\\)" fontset-spec idx)
	(setq idx (match-end 0))
	(setq script (intern (match-string 1 fontset-spec)))
	(if (or (memq script (char-table-extra-slot char-script-table 0))
		(setq script (cdr (assq script charset-script-alist))))
	    (setq fontlist (cons (list script (match-string 2 fontset-spec))
				 fontlist))))
      (setq ascii-font (cadr (assq 'ascii fontlist)))

      ;; Complement FONTLIST.
      (setq fontlist (x-complement-fontset-spec xlfd-fields fontlist))
      (setq name (x-compose-font-name xlfd-fields))
      (new-fontset name fontlist)

      ;; Define the short name alias.
      (if (and (string-match "fontset-.*$" name)
	       (not (assoc name fontset-alias-alist)))
	  (let ((alias (match-string 0 name)))
	    (or (rassoc alias fontset-alias-alist)
		(setq fontset-alias-alist
		      (cons (cons name alias) fontset-alias-alist)))))

      ;; Define the ASCII font name alias.
      (or ascii-font
	  (setq ascii-font (cdr (assq 'ascii fontlist))))
      (or (rassoc ascii-font fontset-alias-alist)
	  (setq fontset-alias-alist
		(cons (cons name ascii-font)
		      fontset-alias-alist))))

    name))

(defun create-fontset-from-ascii-font (font &optional resolved-font
					    fontset-name)
  "Create a fontset from an ASCII font FONT.

Optional 1st arg RESOLVED-FONT is a resolved name of FONT.  If
omitted, `x-resolve-font-name' is called to get the resolved name.  At
this time, if FONT is not available, an error is signaled.

Optional 2nd arg FONTSET-NAME is a string to be used in
`<CHARSET_ENCODING>' fields of a new fontset name.  If it is omitted,
an appropriate name is generated automatically.

It returns a name of the created fontset."
  (setq font (downcase font))
  (setq resolved-font
	(downcase (or resolved-font (x-resolve-font-name font))))
  (let ((xlfd (x-decompose-font-name resolved-font))
	fontset)
    (if fontset-name
	(setq fontset-name (downcase fontset-name))
      (if (query-fontset "fontset-startup")
	  (setq fontset-name
		(subst-char-in-string
		 ?- ?_ (aref xlfd xlfd-regexp-registry-subnum) t))
	(setq fontset-name "startup")))
    (aset xlfd xlfd-regexp-registry-subnum
	  (format "fontset-%s" fontset-name))
    (setq fontset (x-compose-font-name xlfd))
    (or (query-fontset fontset)
	(create-fontset-from-fontset-spec (concat fontset ", ascii:" font)))))


;; Create standard fontset from 16 dots fonts which are the most widely
;; installed fonts.  Fonts for Chinese-GB, Korean, and Chinese-CNS are
;; specified here because FAMILY of those fonts are not "fixed" in
;; many cases.
(defvar standard-fontset-spec
  (purecopy "-*-fixed-medium-r-normal-*-16-*-*-*-*-*-fontset-standard")
  "String of fontset spec of the standard fontset.
You have the biggest chance to display international characters
with correct glyphs by using the standard fontset.
See the documentation of `create-fontset-from-fontset-spec' for the format.")


;; Create fontsets from X resources of the name `fontset-N (class
;; Fontset-N)' where N is integer 0, 1, ...
;; The values of the resources the string of the same format as
;; `standard-fontset-spec'.

(defun create-fontset-from-x-resource ()
  (let ((idx 0)
	fontset-spec)
    (while (setq fontset-spec (x-get-resource (format "fontset-%d" idx)
					      (format "Fontset-%d" idx)))
      (create-fontset-from-fontset-spec fontset-spec t 'noerror)
      (setq idx (1+ idx)))))

;;
(provide 'fontset)

;;; fontset.el ends here

;;; yet-another-launcher.el --- a launcher to launch content in/outside of Emacs

;; Copyright (C) 2010, 2013, 2014, 2017  Free Software Foundation, Inc.

;; Author: Daniel Hannaske <d.hannaske@gmail.com>
;; Version: 0.1
;; Package-Requires: either ido, helm or ivy - I prefer ivy
;; Keywords: 
;; URL: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; This package provides a flexible launcher command that is able to
;; launch three kind of items:
;;    - files/dirs within Emacs (yal/launchable-items-emacs)
;;    - files/dirs opened by os default applications (yal/launchable-items-system)
;;    - urls opened by os default browser (yal/launchable-items-url)

;;;###autoload
     

(provide 'yet-another-launcher)


;;; yet-another-launcher.el ends here

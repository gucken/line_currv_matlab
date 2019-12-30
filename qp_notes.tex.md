

**Matlab programs to compute lines of curvature on the surfaces**\
$$\mathbf{h_a(x,y,z) = x^2+\frac{1}{3}y^2+\frac{1}{5}z^2+axyz = 0}$$

The lines of curvature on the ellipsoid $h_0 = 0$ are intersections of a
triply orthogonal family of quadric surfaces. All of them are closed
curves except for those that lie in the plane $y=0$. In this plane,
there are four umbilic points, two maximal lines of curvature that
connect the umbilic points and two minimal lines of curvature that
connect the umbilic points. The programs described here compute
(approximate) maximal lines of curvature in the family $h_a = 0$ for the
two values $a = 0.11, 0.1857$. Both parameter values still yield four
umbilic points, each with a single separatrix. When $a = 0.11$, each
line of curvature, including the separatrices, appears to be dense in
the surface $h_a = 0$. When $a=0.1857$ there appear to be three closed
lines of curvature that are the limits of all of the other lines of
curvature, including the separatrices.

This a short archive contains the following Matlab scripts and
functions:

-   `qp_coeffs.m`: function that computes Taylor polynomial of degree
    $2$ of $h$.

-   `qp_lcurv.m`: function that evaluates oriented maximal principal
    directions for steps along a line of curvature.

-   `qp_nml.m`: function that computes normal vector to the surface
    $h_a = 0$.

-   `qp_pframe.m`: function that computes an orthonormal frame aligned
    with the principal directions and normal to the surface $h_a = 0$.
    It also computes normal curvatures and "regular" auxiliary
    information in computing the normal curvatures.

-   `qp_po.m`: script that visualizes maximal principal foliation with
    two closed lines of curvature.

-   `qp_proj.m`: function that projects points to surface $h_a = 0$
    along gradient of $h_a$.

-   `qp_qp.m`: script that visualizes maximal principal foliation with a
    dense line of curvature.

-   `qp_step.m`: function that performs an Runge-Kutta step along a line
    of curvature.

-   `qp_traj.m`: function that steps along a line of curvature.

-   `qp_umbilic.m`: function that computes umbilic points of surface
    $h_a = 0$.

The data file `qp_um` has the locations of the four umbilic points on
the surface $h_0 = 0$.

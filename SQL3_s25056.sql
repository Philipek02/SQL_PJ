--zad 1


SELECT AVG(proj.budget)
FROM proj;

--zad 2


SELECT MIN(sal)
FROM emp e, proj p, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
AND proj_emp.projno = 2;
    
--zad 3


SELECT count(*)
FROM emp e, proj p, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
    AND proj_emp.projno = 2;
    
--zad 4


SELECT p.projno, COUNT(*)
FROM emp e, proj p, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
GROUP BY p.projno;

--zad 5


SELECT p.projno, AVG(sal)
FROM emp e, proj p, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
AND pe.projno != 5
GROUP BY p.projno;

--zad 6


SELECT p.projno, job, AVG(sal)
FROM proj p, emp e, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
GROUP BY p.projno, job
ORDER BY p.projno;

--zad 7


SELECT p.projno, MAX(sal)
FROM proj p, emp e, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
GROUP BY p.projno
ORDER BY p.projno;

--zad 8


SELECT p.projno
FROM proj p, emp e, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
GROUP BY p.projno
HAVING COUNT(*) > 2
ORDER BY p.projno;


--zad 9


SELECT p.projno, AVG(sal)
FROM proj p, emp e, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
GROUP BY p.projno
HAVING COUNT(*) > 2
ORDER BY p.projno;

--zad 10


SELECT p.projno NR, AVG(sal) SR, AVG(sal*12 + NVL(comm,0)) SR
FROM emp e, proj p, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
GROUP BY p.projno
ORDER BY p.projno;


--zad 11


SELECT p.projno NR, MAX(sal) - MIN(sal) Roznica
FROM emp e, proj p, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
GROUP BY p.projno
ORDER BY p.projno;

--zad 12


SELECT p.projno, d.deptno, COUNT(*)
FROM emp e, proj p, proj_emp pe, dept d
WHERE p.projno = pe.projno AND e.empno = pe.empno AND e.deptno = d.deptno
AND p.projno = 3
GROUP BY d.deptno, p.projno
HAVING COUNT(*) > 3
ORDER BY d.deptno;

                
--zad 15


SELECT COUNT (*)
FROM emp e, dept d, proj p, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno AND e.deptno = d.deptno
AND d.loc = 'DALLAS' AND p.projno = 4
GROUP BY d.deptno;

--zad 16


SELECT MAX(sal), s.grade 
FROM emp e, salgrade s, proj p, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
    AND sal BETWEEN s.losal AND s.hisal AND p.projno = 2
GROUP BY s.grade;

--zad 18


SELECT AVG(e.sal)
FROM emp e, proj p, proj_emp pe, salgrade s
WHERE p.projno = pe.projno AND e.empno = pe.empno
AND s.grade in (2,3) AND e.sal BETWEEN s.losal AND s.hisal
AND p.projno = 3
GROUP BY s.grade;

--zad 19


SELECT e.mgr , COUNT(*)
FROM emp e, proj p, proj_emp pe
WHERE p.projno = pe.projno AND e.empno = pe.empno
AND p.projno = 2 
GROUP BY e.mgr;

--zad 20


SELECT MAX(p.budget)
FROM emp e, proj p, proj_emp pe, salgrade s
WHERE p.projno = pe.projno AND e.empno = pe.empno
AND s.grade = 1 AND e.sal BETWEEN s.losal AND s.hisal


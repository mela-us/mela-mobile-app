class TestData {
  // static String markdownWithLatex =
  //     "Đây là text bình thường, giờ đến công thức LaTeX:\n" +
  //         "Hợp chất oxy: \\(O_2\\) và \\(H_2O\\)" +
  //         "\nPhân số: \\(\\frac{4}{5}\\) cộng\n với \\(\\frac{a}{b + 1}\\)\nabcd" +
  //         "Chuỗi sigma: \\(\\sum_{i=1}^{n} i^2\\)\n" +
  //         "Text bình thường xen kẽ: Tính tổng từ 1 đến n bằng công thức trên.\n" +
  //         "Công thức\n xuống dòng: \\(a = \\frac{x^2 + y^2}{z}\\)\nmnpp";
  static String markdownWithLatex =
      "Đây là text bình thường \$f(x) = \\sum_{i=0}^{n} \\frac{a_i}{1+x}\$, giờ \\(n!\\) đabc \\(f'(a)\\) thức LaTeX: \nCông thức\n xuống dòng: \\(a = \\frac{x^2 + y^2}{z}\\)\n dsdsdsdsmnpp";

  static const text = r"""
This is inline latex: $f(x) = \sum_{i=0}^{n} \frac{a_i}{1+x}$

This is block level latex:

$$
c = \pm\sqrt{a^2 + b^2}
$$

This is inline latex with displayMode: $$f(x) = \sum_{i=0}^{n} \frac{a_i}{1+x}$$ and here is a very long text that should be in the same line.

The relationship between the height and the side length of an equilateral triangle is:

\[ \text{Height} = \frac{\sqrt{3}}{2} \times \text{Side Length} \]

\[ \text{X} = \frac{1}{2} \times \text{Y} \times \text{Z} = \frac{1}{2} \times 9 \times \frac{\sqrt{3}}{2} \times 9 = \frac{81\sqrt{3}}{4} \]

The basic form of the Taylor series is:

\[f(x) = f(a) + f'(a)(x-a) + \frac{f''(a)}{2!}(x-a)^2 + \frac{f'''(a)}{3!}(x-a)^3 + \cdots\]

where \(f(x)\) is the function to be expanded, \(a\) is the expansion point, \(f'(a)\), abc \(f''(a)\), \(f'''(a)\), etc., are the first, second, third, and so on derivatives of the function at point \(a\), and \(n!\) denotes the factorial of \(n\).

In particular, when \(a=0\), this expansion is called the Maclaurin series.

""";
}

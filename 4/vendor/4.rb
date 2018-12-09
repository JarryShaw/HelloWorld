class Fixnum
  def call prog
    return unless self == 4
    unless prog = prog.delete(' ')[/\A3\.(\d*)4\z/, 1]
      raise SyntaxError, "Program must begin '3.' and end '4'.", caller
    end

    arity = [3, 3, 3, 3, 0, 1, 2, 1, 1, 0]
    cells = [i = pc = 0] * 100
    insns, loops, stack = [], {}, []

    while c = prog[pc]
      op = c.to_i
      insns << [op, arity[op].times.map {
        prog[(pc += 1)..(pc += 1)].to_i
      }]
      stack << i if op == 8
      loops[loops[i] = stack.pop] = i if op == 9
      i  += 1
      pc += 1
    end

    ip = -1
    while (ip += 1) < insns.size
      op, (a, b, c) = insns[ip]
      case op
      when 0..3; cells[a] = cells[b].send '+-*/'[op], cells[c]
      when 4; exit
      when 5; print cells[a].chr
      when 6; cells[a] = b
      when 7; cells[a] = STDIN.getc.ord
      when 8; ip = loops[ip] if cells[a].zero?
      when 9; ip = loops[ip]
      end
    end
  end
end

# Execute the cat program.
4.('3.6000180071051094')
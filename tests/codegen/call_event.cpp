#include "common.h"

namespace bpftrace {
namespace test {
namespace codegen {

TEST(codegen, call_event)
{
  test("kprobe:f { @x = event(pid) }",

       NAME);
}

} // namespace codegen
} // namespace test
} // namespace bpftrace

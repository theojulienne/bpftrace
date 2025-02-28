; ModuleID = 'bpftrace'
source_filename = "bpftrace"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf-pc-linux"

; Function Attrs: nounwind
declare i64 @llvm.bpf.pseudo(i64 %0, i64 %1) #0

define i64 @"kretprobe:vfs_read"(i8* %0) section "s_kretprobe:vfs_read_1" {
entry:
  %"@_val" = alloca i64, align 8
  %lookup_elem_val = alloca i64, align 8
  %comm9 = alloca [16 x i8], align 1
  %strcmp.result = alloca i1, align 1
  %comm = alloca [16 x i8], align 1
  %1 = bitcast [16 x i8]* %comm to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %1)
  %2 = bitcast [16 x i8]* %comm to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %2, i8 0, i64 16, i1 false)
  %get_comm = call i64 inttoptr (i64 16 to i64 ([16 x i8]*, i64)*)([16 x i8]* %comm, i64 16)
  %3 = bitcast i1* %strcmp.result to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %3)
  store i1 true, i1* %strcmp.result, align 1
  %4 = getelementptr [16 x i8], [16 x i8]* %comm, i32 0, i32 0
  %5 = load i8, i8* %4, align 1
  %strcmp.cmp = icmp ne i8 %5, 115
  br i1 %strcmp.cmp, label %strcmp.false, label %strcmp.loop

pred_false:                                       ; preds = %strcmp.false
  ret i64 0

pred_true:                                        ; preds = %strcmp.false
  %6 = bitcast [16 x i8]* %comm9 to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %6)
  %7 = bitcast [16 x i8]* %comm9 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %7, i8 0, i64 16, i1 false)
  %get_comm10 = call i64 inttoptr (i64 16 to i64 ([16 x i8]*, i64)*)([16 x i8]* %comm9, i64 16)
  %pseudo = call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %lookup_elem = call i8* inttoptr (i64 1 to i8* (i64, [16 x i8]*)*)(i64 %pseudo, [16 x i8]* %comm9)
  %8 = bitcast i64* %lookup_elem_val to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %8)
  %map_lookup_cond = icmp ne i8* %lookup_elem, null
  br i1 %map_lookup_cond, label %lookup_success, label %lookup_failure

strcmp.false:                                     ; preds = %strcmp.loop7, %strcmp.loop5, %strcmp.loop3, %strcmp.loop1, %strcmp.loop, %entry
  %9 = load i1, i1* %strcmp.result, align 1
  %10 = bitcast i1* %strcmp.result to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %10)
  %11 = zext i1 %9 to i64
  %12 = bitcast [16 x i8]* %comm to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %12)
  %predcond = icmp eq i64 %11, 0
  br i1 %predcond, label %pred_false, label %pred_true

strcmp.loop:                                      ; preds = %entry
  %13 = getelementptr [16 x i8], [16 x i8]* %comm, i32 0, i32 1
  %14 = load i8, i8* %13, align 1
  %strcmp.cmp2 = icmp ne i8 %14, 115
  br i1 %strcmp.cmp2, label %strcmp.false, label %strcmp.loop1

strcmp.loop1:                                     ; preds = %strcmp.loop
  %15 = getelementptr [16 x i8], [16 x i8]* %comm, i32 0, i32 2
  %16 = load i8, i8* %15, align 1
  %strcmp.cmp4 = icmp ne i8 %16, 104
  br i1 %strcmp.cmp4, label %strcmp.false, label %strcmp.loop3

strcmp.loop3:                                     ; preds = %strcmp.loop1
  %17 = getelementptr [16 x i8], [16 x i8]* %comm, i32 0, i32 3
  %18 = load i8, i8* %17, align 1
  %strcmp.cmp6 = icmp ne i8 %18, 100
  br i1 %strcmp.cmp6, label %strcmp.false, label %strcmp.loop5

strcmp.loop5:                                     ; preds = %strcmp.loop3
  %19 = getelementptr [16 x i8], [16 x i8]* %comm, i32 0, i32 4
  %20 = load i8, i8* %19, align 1
  %strcmp.cmp8 = icmp ne i8 %20, 0
  br i1 %strcmp.cmp8, label %strcmp.false, label %strcmp.loop7

strcmp.loop7:                                     ; preds = %strcmp.loop5
  store i1 false, i1* %strcmp.result, align 1
  br label %strcmp.false

lookup_success:                                   ; preds = %pred_true
  %cast = bitcast i8* %lookup_elem to i64*
  %21 = load i64, i64* %cast, align 8
  store i64 %21, i64* %lookup_elem_val, align 8
  br label %lookup_merge

lookup_failure:                                   ; preds = %pred_true
  store i64 0, i64* %lookup_elem_val, align 8
  br label %lookup_merge

lookup_merge:                                     ; preds = %lookup_failure, %lookup_success
  %22 = load i64, i64* %lookup_elem_val, align 8
  %23 = bitcast i64* %lookup_elem_val to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %23)
  %24 = bitcast i64* %"@_val" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* %24)
  %25 = add i64 %22, 1
  store i64 %25, i64* %"@_val", align 8
  %pseudo11 = call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %update_elem = call i64 inttoptr (i64 2 to i64 (i64, [16 x i8]*, i64*, i64)*)(i64 %pseudo11, [16 x i8]* %comm9, i64* %"@_val", i64 0)
  %26 = bitcast i64* %"@_val" to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %26)
  %27 = bitcast [16 x i8]* %comm9 to i8*
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* %27)
  ret i64 0
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg %0, i8* nocapture %1) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly %0, i8 %1, i64 %2, i1 immarg %3) #2

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg %0, i8* nocapture %1) #1

attributes #0 = { nounwind }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { argmemonly nofree nosync nounwind willreturn writeonly }

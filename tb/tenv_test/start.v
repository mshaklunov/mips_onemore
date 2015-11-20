task start;
  begin
  @(posedge clk); @(posedge clk);
  test_active= 1;
  wait(!test_active);
  end
endtask


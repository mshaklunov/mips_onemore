task start;
  begin
  test_active= 1;
  wait(!test_active);
  end
endtask


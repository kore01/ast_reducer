CREATE TRIGGER trg_nhmai AFTER DELETE ON tbl_wqiwo  BEGIN UPDATE tbl_wqiwo SET tcol_vwipe = 'v_rvcwt', icol_dhwup = -5799;

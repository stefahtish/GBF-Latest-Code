page 51261 "Finance Manager RC"
{
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            // part(Control76; "Headline RC Accountant")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            part("Finance Management Cues"; "Finance Management Cues")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(embedding)
        {
            action("Approval Request Entries")
            {
                RunObject = Page "Approval Request Entries";
            }
            action("Approval Entries")
            {
                ApplicationArea = Basic, suite;
                Caption = 'Approval Entries';
                RunObject = Page "Approval Entries";
                RunPageLink = Finance = const(true);
            }
            action("vendor")
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = page "Vendor List";
                RunPageLink = "Vendor Type" = filter(<> "Share holder");
            }
            action("Shareholder")
            {
                Caption = 'Share holders';
                Image = VendorBill;
                RunObject = page "Shareholders List";
            }
        }
        area(sections)
        {
            group("Group")
            {
                Caption = 'General Ledger';

                action("Chart of Accounts12")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                    RunObject = page "Chart of Accounts";
                }
                action("Budgets")
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Budgets';
                    RunObject = page "G/L Budget Names";
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Schedules';
                    RunObject = page "Account Schedule Names";
                }
                action("Analyses by Dimensions")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis by Dimensions';
                    RunObject = page "Analysis View List";
                }
                group("Group1")
                {
                    Caption = 'VAT';

                    action("VAT Statements")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Statements';
                        RunObject = page "VAT Statement";
                    }
                    action("VAT Returns")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Returns';
                        RunObject = page "VAT Report List";
                    }
                    // action("ECSL Report")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Caption = 'EC Sales List Reports';
                    //     RunObject = page "EC Sales List Reports"
                    // }
                    group("Group2")
                    {
                        Caption = 'Reports';

                        action("VAT Exceptions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT Exceptions';
                            RunObject = report "VAT Exceptions";
                        }
                        action("VAT Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT Register';
                            RunObject = report "VAT Register";
                        }
                        action("VAT Registration No. Check")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Batch VAT Registration No. Check';
                            RunObject = report "VAT Registration No. Check";
                        }
                        action("VAT Statement")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT Statement';
                            RunObject = report "VAT Statement";
                        }
                        action("VAT- VIES Declaration Tax Auth")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT- VIES Declaration Tax Auth';
                            RunObject = report "VAT- VIES Declaration Tax Auth";
                        }
                        action("VAT- VIES Declaration Disk")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT- VIES Declaration Disk...';
                            RunObject = report "VAT- VIES Declaration Disk";
                        }
                        action("Day Book VAT Entry")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Day Book VAT Entry';
                            RunObject = report "Day Book VAT Entry";
                        }
                        action("Day Book Cust. Ledger Entry")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Day Book Cust. Ledger Entry';
                            RunObject = report "Day Book Cust. Ledger Entry";
                        }
                        action("Day Book Vendor Ledger Entry")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Day Book Vendor Ledger Entry';
                            RunObject = report "Day Book Vendor Ledger Entry";
                        }
                    }
                }
                group("Group3")
                {
                    Caption = 'Intercompany';

                    action("General Journals")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany General Journal';
                        RunObject = page "IC General Journal";
                    }
                    action("Inbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Inbox Transactions';
                        RunObject = page "IC Inbox Transactions";
                    }
                    action("Outbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Outbox Transactions';
                        RunObject = page "IC Outbox Transactions";
                    }
                    action("Handled Inbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Handled Intercompany Inbox Transactions';
                        RunObject = page "Handled IC Inbox Transactions";
                    }
                    action("Handled Outbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Handled Intercompany Outbox Transactions';
                        RunObject = page "Handled IC Outbox Transactions";
                    }
                    action("Intercompany Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'IC Transaction';
                        RunObject = report "IC Transactions";
                    }
                }
                group("Group4")
                {
                    Caption = 'Consolidation';

                    action("Business Units")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Business Units';
                        RunObject = page "Business Unit List";
                    }
                    action("Export Consolidation")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Export Consolidation...';
                        RunObject = report "Export Consolidation";
                    }
                    action("G/L Consolidation Eliminations")
                    {
                        ApplicationArea = Suite;
                        Caption = 'G/L Consolidation Eliminations';
                        RunObject = report "G/L Consolidation Eliminations";
                    }
                }
                group("Group5")
                {
                    Caption = 'Journals';

                    action("General Journals1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Journals';
                        RunObject = page "General Journal";
                    }
                    action("Recurring Journals")
                    {
                        ApplicationArea = Suite, FixedAssets;
                        Caption = 'Recurring General Journals';
                        RunObject = page "Recurring General Journal";
                    }
                    action("Intrastat Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Intrastat Journals';
                        RunObject = page "Intrastat Journal";
                    }
                    action("General Journals2")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany General Journal';
                        RunObject = page "IC General Journal";
                    }
                }
                group("Group6")
                {
                    Caption = 'Register/Entries';

                    action("G/L Registers12")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                    }
                    action("Navigate")
                    {
                        ApplicationArea = Basic, Suite, FixedAssets, CostAccounting;
                        Caption = 'Navigate';
                        RunObject = page "Navigate";
                    }
                    action("General Ledger Entries12")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Ledger Entries';
                        RunObject = page "General Ledger Entries";
                    }
                    action("G/L Budget Entries12")
                    {
                        ApplicationArea = Suite;
                        Caption = 'G/L Budget Entries';
                        RunObject = page "G/L Budget Entries";
                    }
                    action("VAT Entries12")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Entries';
                        RunObject = page "VAT Entries";
                    }
                    action("Analysis View Entries12")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Analysis View Entries';
                        RunObject = page "Analysis View Entries";
                    }
                    action("Analysis View Budget Entries12")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Analysis View Budget Entries';
                        RunObject = page "Analysis View Budget Entries";
                    }
                    action("Item Budget Entries12")
                    {
                        ApplicationArea = ItemBudget;
                        Caption = 'Item Budget Entries';
                        RunObject = page "Item Budget Entries";
                    }
                }
                group("Group7")
                {
                    Caption = 'Reports';

                    group("Group8")
                    {
                        Caption = 'Entries';

                        action("G/L Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'G/L Register';
                            RunObject = report "G/L Register";
                        }
                        action("Detail Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Detail Trial Balance';
                            RunObject = report "Detail Trial Balance";
                        }
                        action("Dimensions - Detail")
                        {
                            ApplicationArea = Dimensions;
                            Caption = 'Dimensions - Detail';
                            RunObject = report "Dimensions - Detail";
                        }
                        action("Dimensions - Total")
                        {
                            ApplicationArea = Dimensions;
                            Caption = 'Dimensions - Total';
                            RunObject = report "Dimensions - Total";
                        }
                        action("Check Value Posting")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Dimension Check Value Posting';
                            RunObject = report "Check Value Posting";
                        }
                    }
                    group("Group9")
                    {
                        Caption = 'Financial Statement';

                        action("Account Schedule")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Schedule';
                            RunObject = report "Account Schedule";
                        }
                        action("Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Trial Balance';
                            RunObject = report "Trial Balance";
                        }
                        action("Trial Balance/Budget")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Trial Balance/Budget';
                            RunObject = report "Trial Balance/Budget";
                        }
                        action("Budget Variance Analysis")
                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Budget Variance Analysis';
                            RunObject = report "Budget Variance Analysis";
                        }
                        action("Trial Balance/Previous Year")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Trial Balance/Previous Year';
                            RunObject = report "Trial Balance/Previous Year";
                        }
                        action("Closing Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Closing Trial Balance';
                            RunObject = report "Closing Trial Balance";
                        }
                        action("Consolidated Trial Balance")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Consolidated Trial Balance';
                            RunObject = report "Consolidated Trial Balance";
                        }
                        action("Consolidated Trial Balance (4)")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Consolidated Trial Balance (4)';
                            RunObject = report "Consolidated Trial Balance (4)";
                        }
                        action("Budget")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Budget';
                            RunObject = report "Budget";
                        }
                        action("Trial Balance by Period")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Trial Balance by Period';
                            RunObject = report "Trial Balance by Period";
                        }
                        action("Fiscal Year Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fiscal Year Balance';
                            RunObject = report "Fiscal Year Balance";
                        }
                        action("Balance Comp. - Prev. Year")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Balance Comp. - Prev. Year';
                            RunObject = report "Balance Comp. - Prev. Year";
                        }
                        action("Balance Sheet")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Balance Sheet';
                            RunObject = codeunit "Run Acc. Sched. Balance Sheet";
                            AccessByPermission = tabledata "G/L Account" = R;
                        }
                        action("Income Statement")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Income Statement';
                            RunObject = codeunit "Run Acc. Sched. Income Stmt.";
                            AccessByPermission = tabledata "G/L Account" = R;
                        }
                        action("Statement of Cashflows")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Statement';
                            RunObject = codeunit "Run Acc. Sched. CashFlow Stmt.";
                            AccessByPermission = tabledata "G/L Account" = R;
                        }
                        action("Statement of Retained Earnings")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Retained Earnings Statement';
                            RunObject = codeunit "Run Acc. Sched. Retained Earn.";
                            AccessByPermission = tabledata "G/L Account" = R;
                        }
                    }
                    group("Group10")
                    {
                        Caption = 'Miscellaneous';

                        action("Intrastat - Checklist")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Intrastat - Checklist';
                            RunObject = report "Intrastat - Checklist";
                        }
                        action("Intrastat - Form")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Intrastat - Form';
                            RunObject = report "Intrastat - Form";
                        }
                        action("Foreign Currency Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Foreign Currency Balance';
                            RunObject = report "Foreign Currency Balance";
                        }
                        action("XBRL Spec. 2 Instance Document")
                        {
                            ApplicationArea = XBRL;
                            Caption = 'XBRL Spec. 2 Instance Document';
                            //  RunObject = report "XBRL Export Instance - Spec. 2";
                        }
                        action("XBRL Mapping of G/L Accounts")
                        {
                            ApplicationArea = XBRL;
                            Caption = 'XBRL Mapping of G/L Accounts';
                            //RunObject = report "XBRL Mapping of G/L Accounts";
                        }
                        action("Reconcile Cust. and Vend. Accs")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Reconcile Cust. and Vend. Accs';
                            RunObject = report "Reconcile Cust. and Vend. Accs";
                        }
                        action("G/L Deferral Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'G/L Deferral Summary';
                            RunObject = report "Deferral Summary - G/L";
                        }
                    }
                    group("Group11")
                    {
                        Caption = 'Setup List';

                        action("Chart of Accounts1")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Chart of Accounts';
                            RunObject = report "Chart of Accounts";
                        }
                        action("Change Log Setup List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Change Log Setup List';
                            RunObject = report "Change Log Setup List";
                        }
                    }
                }
                group("Group12")
                {
                    Caption = 'Setup';

                    action("General Ledger Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Ledger Setup';
                        RunObject = page "General Ledger Setup";
                    }
                    action("Deferral Template List")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Deferral Templates';
                        RunObject = page "Deferral Template List";
                    }
                    action("Journal Templates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Journal Templates';
                        RunObject = page "General Journal Templates";
                    }
                    action("G/L Account Categories")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Account Categories';
                        RunObject = page "G/L Account Categories";
                        AccessByPermission = tabledata "G/L Account Category" = R;
                    }
                    action("XBRL Taxonomies")
                    {
                        ApplicationArea = XBRL;
                        Caption = 'XBRL Taxonomies';
                        //RunObject = page "XBRL Taxonomies";
                    }
                    action("VAT Report Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Report Setup';
                        RunObject = page "VAT Report Setup";
                    }
                }
            }
            group("Group13")
            {
                Caption = 'Cash Management';

                action("Bank Accounts12")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    RunObject = page "Bank Account List";
                }
                // action("Closed bank confirmation")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Bank Confirmation";
                //     RunPageLink = Closed = const(true);
                // }
                action("Receivables-Payables")
                {
                    ApplicationArea = Suite;
                    Caption = 'Receivables-Payables';
                    RunObject = page "Receivables-Payables";
                }
                action("Payment Registration")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Registration';
                    RunObject = page "Payment Registration";
                }
                group("Group14")
                {
                    Caption = 'Cash Flow';

                    action("Cash Flow Forecasts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Forecasts';
                        RunObject = page "Cash Flow Forecast List";
                    }
                    action("Chart of Cash Flow Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Chart of Cash Flow Accounts';
                        RunObject = page "Chart of Cash Flow Accounts";
                    }
                    action("Cash Flow Manual Revenues")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Manual Revenues';
                        RunObject = page "Cash Flow Manual Revenues";
                    }
                    action("Cash Flow Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Manual Expenses';
                        RunObject = page "Cash Flow Manual Expenses";
                    }
                    action("Cash Flow Worksheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Worksheet';
                        RunObject = page "Cash Flow Worksheet";
                    }
                }
                group("Group15")
                {
                    Caption = 'Reconciliation';

                    action("Bank Account Reconciliations")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Reconciliations';
                        RunObject = page "Bank Acc. Reconciliation List";
                    }
                    action("Posted Payment Reconciliations12")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Payment Reconciliations';
                        RunObject = page "Posted Payment Reconciliations";
                    }
                    action("Payment Reconciliation Journals12")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Reconciliation Journals';
                        RunObject = page "Pmt. Reconciliation Journals";
                    }
                }
                group("Group16")
                {
                    Caption = 'Journals';

                    action("Cash Receipt Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Receipt Journals';
                        RunObject = page "Cash Receipt Journal";
                    }
                    action("Payment Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Journals';
                        RunObject = page "Payment Journal";
                    }
                    action("Payment Reconciliation Journals1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Reconciliation Journals';
                        RunObject = page "Pmt. Reconciliation Journals";
                    }
                }
                group("Group17")
                {
                    Caption = 'Ledger Entries';

                    action("Bank Account Ledger Entries12")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Ledger Entries';
                        RunObject = page "Bank Account Ledger Entries";
                    }
                    action("Check Ledger Entries12")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Check Ledger Entries';
                        RunObject = page "Check Ledger Entries";
                    }
                    action("Cash Flow Ledger Entries1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Ledger Entries';
                        RunObject = page "Cash Flow Forecast Entries";
                    }
                }
                group("Group18")
                {
                    Caption = 'Reports';

                    action("Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Register';
                        RunObject = report "Bank Account Register";
                    }
                    action("Check Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account - Check Details';
                        RunObject = report "Bank Account - Check Details";
                    }
                    action("Labels")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account - Labels';
                        RunObject = report "Bank Account - Labels";
                    }
                    action("List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account - List';
                        RunObject = report "Bank Account - List";
                    }
                    action("Detail Trial Bal.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Acc. - Detail Trial Bal.';
                        RunObject = report "Bank Acc. - Detail Trial Bal.";
                    }
                    action("Receivables-Payables1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receivables-Payables';
                        RunObject = report "Receivables-Payables";
                    }
                    action("Cash Flow Date List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Date List';
                        RunObject = report "Cash Flow Date List";
                    }
                    action("Dimensions - Detail1")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Cash Flow Dimensions - Detail';
                        RunObject = report "Cash Flow Dimensions - Detail";
                    }
                }
                group("Group19")
                {
                    Caption = 'Setup';

                    action("Payment Application Rules")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Application Rules';
                        RunObject = page "Payment Application Rules";
                    }
                    action("Cash Flow Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Setup';
                        RunObject = page "Cash Flow Setup";
                    }
                    action("Report Selection - Cash Flow")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Report Selections';
                        RunObject = page "Report Selection - Cash Flow";
                    }
                    action("Report Selection - Bank Acc.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Report Selections Bank Account';
                        RunObject = page "Report Selection - Bank Acc.";
                    }
                    action("Payment Terms")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Terms';
                        RunObject = page "Payment Terms";
                    }
                    action("Payment Methods")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Methods';
                        RunObject = page "Payment Methods";
                    }
                    action("Currencies")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Currencies';
                        RunObject = page "Currencies";
                    }
                }
            }
            group("Group28")
            {
                Caption = 'Receivables';

                action("Customers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    RunObject = page "Customer List";
                }
                action("Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    RunObject = page "Sales Invoice List";
                }
                action("Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memos';
                    RunObject = page "Sales Credit Memos";
                }
                action("Direct Debit Collections")
                {
                    ApplicationArea = Suite;
                    Caption = 'Direct Debit Collections';
                    RunObject = page "Direct Debit Collections";
                }
                action("Create Recurring Sales Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Recurring Sales Invoices';
                    RunObject = report "Create Recurring Sales Inv.";
                }
                action("Register Customer Payments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Register Customer Payments';
                    RunObject = page "Payment Registration";
                }
                group("Group29")
                {
                    Caption = 'Combine';

                    action("Combined Shipments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Combine Shipments...';
                        RunObject = report "Combine Shipments";
                    }
                    action("Combined Return Receipts")
                    {
                        ApplicationArea = SalesReturnOrder, PurchReturnOrder;
                        Caption = 'Combine Return Receipts...';
                        RunObject = report "Combine Return Receipts";
                    }
                }
                group("Group30")
                {
                    Caption = 'Collection';

                    action("Reminders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Reminders';
                        RunObject = page "Reminder List";
                    }
                    action("Issued Reminders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued Reminders';
                        RunObject = page "Issued Reminder List";
                    }
                    action("Finance Charge Memos")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Finance Charge Memos';
                        RunObject = page "Finance Charge Memo List";
                    }
                    action("Issued Finance Charge Memos")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued Finance Charge Memos';
                        RunObject = page "Issued Fin. Charge Memo List";
                    }
                }
                group("Group31")
                {
                    Caption = 'Journals';

                    action("Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Journals';
                        RunObject = page "Sales Journal";
                    }
                    action("Cash Receipt Journal1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Receipt Journals';
                        RunObject = page "Cash Receipt Journal";
                    }
                }
                group("Group33")
                {
                    Caption = 'Registers/Entries';

                    action("G/L Registers1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                    }
                    action("Customer Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Ledger Entries';
                        RunObject = page "Customer Ledger Entries";
                    }
                    action("Reminder/Fin. Charge Entries")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Reminder/Fin. Charge Entries';
                        RunObject = page "Reminder/Fin. Charge Entries";
                    }
                    action("Detailed Cust. Ledg. Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Detailed Customer Ledger Entries';
                        RunObject = page "Detailed Cust. Ledg. Entries";
                    }
                }
                group("Group34")
                {
                    Caption = 'Reports';

                    action("Customer Detailed Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Detailed Aging';
                        RunObject = report "Customer Detailed Aging";
                    }
                    action("Customer Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Statement';
                        RunObject = codeunit "Customer Layout - Statement";
                    }
                    action("Customer Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Register';
                        RunObject = report "Customer Register";
                    }
                    action("Customer - Balance to Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Balance to Date';
                        RunObject = report "Customer - Balance to Date";
                    }
                    action("Customer - Detail Trial Bal.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Detail Trial Bal.';
                        RunObject = report "Customer - Detail Trial Bal.";
                    }
                    action("Customer - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - List';
                        RunObject = report "Customer - List";
                    }
                    action("Customer - Summary Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Summary Aging';
                        RunObject = report "Customer - Summary Aging";
                    }
                    action("Customer - Summary Aging Simp.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Summary Aging Simp.';
                        RunObject = report "Customer - Summary Aging Simp.";
                    }
                    action("Customer - Order Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Order Summary';
                        RunObject = report "Customer - Order Summary";
                    }
                    action("Customer - Order Detail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Order Detail';
                        RunObject = report "Customer - Order Detail";
                    }
                    action("Customer - Labels")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer Labels';
                        RunObject = report "Customer - Labels";
                    }
                    action("Customer - Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Top 10 List';
                        RunObject = report "Customer - Top 10 List";
                    }
                    action("Sales Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Statistics';
                        RunObject = report "Sales Statistics";
                    }
                    action("Customer/Item Sales")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer/Item Sales';
                        RunObject = report "Customer/Item Sales";
                    }
                    action("Salesperson - Sales Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Salesperson Sales Statistics';
                        RunObject = report "Salesperson - Sales Statistics";
                    }
                    action("Salesperson - Commission")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Salesperson Commission';
                        RunObject = report "Salesperson - Commission";
                    }
                    action("Customer - Sales List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Sales List';
                        RunObject = report "Customer - Sales List";
                    }
                    action("Aged Accounts Receivable")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        RunObject = report "Aged Accounts Receivable";
                    }
                    action("Customer - Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Trial Balance';
                        RunObject = report "Customer - Trial Balance";
                    }
                    action("EC Sales List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'EC Sales List';
                        RunObject = report "EC Sales List";
                    }
                }
                group("Group35")
                {
                    Caption = 'Setup';

                    action("Sales & Receivables Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales & Receivables Setup';
                        RunObject = page "Sales & Receivables Setup";
                    }
                    action("Payment Registration Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Registration Setup';
                        RunObject = page "Payment Registration Setup";
                    }
                    action("Report Selection Reminder and")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Report Selections Reminder/Fin. Charge';
                        RunObject = page "Report Selection - Reminder";
                    }
                    action("Reminder Terms")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Reminder Terms';
                        RunObject = page "Reminder Terms";
                    }
                    action("Finance Charge Terms")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Finance Charge Terms';
                        RunObject = page "Finance Charge Terms";
                    }
                }
            }
            group("Group36")
            {
                Caption = 'Payables';

                action("Vendors12")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    RunObject = page "Vendor List";
                    RunPageLink = "Vendor Type" = filter(<> "Share holder");
                }
                action("Vendors13")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Share Holders';
                    RunObject = page "Vendor List";
                    RunPageLink = "Vendor Type" = filter("Share holder");
                }
                action("Invoices1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                }
                action("Credit Memos1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                }
                action("Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Documents';
                    RunObject = page "Incoming Documents";
                }
                group("Group37")
                {
                    Caption = 'Journals';

                    action("Purchase Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Journals';
                        RunObject = page "Purchase Journal";
                    }
                    action("Payment Journals1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Journals';
                        RunObject = page "Payment Journal";
                    }
                }
                group("Group39")
                {
                    Caption = 'Registers/Entries';

                    action("G/L Registers2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                    }
                    action("Vendor Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Ledger Entries';
                        RunObject = page "Vendor Ledger Entries";
                    }
                    action("Detailed Cust. Ledg. Entries1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Detailed Vendor Ledger Entries';
                        RunObject = page "Detailed Vendor Ledg. Entries";
                    }
                    action("Credit Transfer Registers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Credit Transfer Registers';
                        RunObject = page "Credit Transfer Registers";
                    }
                    action("Employee Ledger Entries")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Employee Ledger Entries';
                        RunObject = page "Employee Ledger Entries";
                    }
                    // action("Detailed Employee Ledger Entries")
                    // {
                    //     ApplicationArea = BasicHR;
                    //     Caption = 'Detailed Employee Ledger Entries';
                    //     RunObject = page "Detailed Empl. Ledger Entries";
                    // }
                }
                group("Group40")
                {
                    Caption = 'Reports';

                    action("Aged Accounts Payable")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Payable';
                        RunObject = report "Aged Accounts Payable";
                    }
                    action("Payments on Hold")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payments on Hold';
                        RunObject = report "Payments on Hold";
                    }
                    action("Purchase Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Statistics';
                        RunObject = report "Purchase Statistics";
                    }
                    action("Vendor Item Catalog")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Item Catalog';
                        RunObject = report "Vendor Item Catalog";
                    }
                    action("Vendor Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Register';
                        RunObject = report "Vendor Register";
                    }
                    action("Vendor - Balance to Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Balance to Date';
                        RunObject = report "Vendor - Balance to Date";
                    }
                    action("Vendor - Detail Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Detail Trial Balance';
                        RunObject = report "Vendor - Detail Trial Balance";
                    }
                    action("Vendor - Labels")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Labels';
                        RunObject = report "Vendor - Labels";
                    }
                    action("Vendor - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - List';
                        RunObject = report "Vendor - List";
                    }
                    action("Vendor - Order Detail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Order Detail';
                        RunObject = report "Vendor - Order Detail";
                    }
                    action("Vendor - Order Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Order Summary';
                        RunObject = report "Vendor - Order Summary";
                    }
                    action("Vendor - Purchase List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Purchase List';
                        RunObject = report "Vendor - Purchase List";
                    }
                    action("Vendor - Summary Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Summary Aging';
                        RunObject = report "Vendor - Summary Aging";
                    }
                    action("Vendor - Top 10 List")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Top 10 List';
                        RunObject = report "Vendor - Top 10 List";
                    }
                    action("Vendor - Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Trial Balance';
                        RunObject = report "Vendor - Trial Balance";
                    }
                    action("Vendor/Item Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor/Item Purchases';
                        RunObject = report "Vendor/Item Purchases";
                    }
                }
                group("Group41")
                {
                    Caption = 'Setup';

                    action("Purchases & Payables Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchases & Payables Setup';
                        RunObject = page "Purchases & Payables Setup";
                    }
                }
            }
            group("Group42")
            {
                Caption = 'Fixed Assets';

                action("Fixed Assets12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = page "Fixed Asset List";
                }
                action("Fixed Asset Disposal")
                {
                    ApplicationArea = FixedAssets;
                    RunObject = page "FA Disposal List";
                    RunPageLink = Status = filter(Approved);
                }
                action("Insurance12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    RunObject = page "Insurance List";
                }
                action("Calculate Depreciation...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Depreciation...';
                    RunObject = report "Calculate Depreciation";
                }
                action("Fixed Assets...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Fixed Assets...';
                    RunObject = report "Index Fixed Assets";
                }
                action("Insurance...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Insurance...';
                    RunObject = report "Index Insurance";
                }
                group("Group43")
                {
                    Caption = 'Journals';

                    action("G/L Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA G/L Journals';
                        RunObject = page "Fixed Asset G/L Journal";
                    }
                    action("FA Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Journals';
                        RunObject = page "Fixed Asset Journal";
                    }
                    action("FA Reclass. Journal")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Reclassification Journals';
                        RunObject = page "FA Reclass. Journal";
                    }
                    action("Insurance Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journals';
                        RunObject = page "Insurance Journal";
                    }
                    action("Recurring Journals1")
                    {
                        ApplicationArea = Suite, FixedAssets;
                        Caption = 'Recurring General Journals';
                        RunObject = page "Recurring General Journal";
                    }
                    action("Recurring Fixed Asset Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Recurring Fixed Asset Journals';
                        RunObject = page "Recurring Fixed Asset Journal";
                    }
                }
                group("Group44")
                {
                    Caption = 'Reports';

                    group("Group45")
                    {
                        Caption = 'Fixed Assets';

                        action("Posting Group - Net Change")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Posting Group - Net Change';
                            RunObject = report "FA Posting Group - Net Change";
                        }
                        action("Register1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Register';
                            RunObject = report "Fixed Asset Register";
                        }
                        action("Acquisition List")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Acquisition List';
                            RunObject = report "Fixed Asset - Acquisition List";
                        }
                        action("Analysis1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Analysis';
                            RunObject = report "Fixed Asset - Analysis";
                        }
                        action("Book Value 01")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Book Value 01';
                            RunObject = report "Fixed Asset - Book Value 01";
                        }
                        action("Book Value 02")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Book Value 02';
                            RunObject = report "Fixed Asset - Book Value 02";
                        }
                        action("Details")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Details';
                            RunObject = report "Fixed Asset - Details";
                        }
                        action("G/L Analysis")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA G/L Analysis';
                            RunObject = report "Fixed Asset - G/L Analysis";
                        }
                        action("List1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA List';
                            RunObject = report "Fixed Asset - List";
                        }
                        action("Projected Value")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Projected Value';
                            RunObject = report "Fixed Asset - Projected Value";
                        }
                    }
                    group("Group46")
                    {
                        Caption = 'Insurance';

                        action("Uninsured FAs")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Uninsured FAs';
                            RunObject = report "Insurance - Uninsured FAs";
                        }
                        action("Register2")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Register';
                            RunObject = report "Insurance Register";
                        }
                        action("Analysis2")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Analysis';
                            RunObject = report "Insurance - Analysis";
                        }
                        action("Coverage Details")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Coverage Details';
                            RunObject = report "Insurance - Coverage Details";
                        }
                        action("List2")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance List';
                            RunObject = report "Insurance - List";
                        }
                        action("Tot. Value Insured")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Total Value Insured';
                            RunObject = report "Insurance - Tot. Value Insured";
                        }
                    }
                    group("Group47")
                    {
                        Caption = 'Maintenance';

                        action("Register3")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Register';
                            RunObject = report "Maintenance Register";
                        }
                        action("Analysis3")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Analysis';
                            RunObject = report "Maintenance - Analysis";
                        }
                        action("Details1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Details';
                            RunObject = report "Maintenance - Details";
                        }
                        action("Next Service")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Next Service';
                            RunObject = report "Maintenance - Next Service";
                        }
                    }
                }
                group("Group48")
                {
                    Caption = 'Registers/Entries';

                    action("FA Registers12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Registers';
                        RunObject = page "FA Registers";
                    }
                    action("Insurance Registers12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Registers';
                        RunObject = page "Insurance Registers";
                    }
                    action("FA Ledger Entries12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Ledger Entries';
                        RunObject = page "FA Ledger Entries";
                    }
                    action("Maintenance Ledger Entries12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance Ledger Entries';
                        RunObject = page "Maintenance Ledger Entries";
                    }
                    action("Ins. Coverage Ledger Entries12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Coverage Ledger Entries';
                        RunObject = page "Ins. Coverage Ledger Entries";
                    }
                }
                group("Group49")
                {
                    Caption = 'Setup';

                    action("FA Setup")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Setup';
                        RunObject = page "Fixed Asset Setup";
                    }
                    action("FA Classes")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Classes';
                        RunObject = page "FA Classes";
                    }
                    action("FA Subclasses")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Subclasses';
                        RunObject = page "FA Subclasses";
                    }
                    action("FA Locations")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Locations';
                        RunObject = page "FA Locations";
                    }
                    action("Insurance Types")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Types';
                        RunObject = page "Insurance Types";
                    }
                    action("Maintenance")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance';
                        RunObject = page "Maintenance";
                    }
                    action("Depreciation Books")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Books';
                        RunObject = page "Depreciation Book List";
                    }
                    action("Depreciation Tables")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Tables';
                        RunObject = page "Depreciation Table List";
                    }
                    action("FA Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Journal Templates';
                        RunObject = page "FA Journal Templates";
                    }
                    action("FA Reclass. Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Reclassification Journal Template';
                        RunObject = page "FA Reclass. Journal Templates";
                    }
                    action("Insurance Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journal Templates';
                        RunObject = page "Insurance Journal Templates";
                    }
                }
            }
            group("Group50")
            {
                Caption = 'Inventory';

                action("Item List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Item List";
                }
                action("Inventory Periods12")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory Periods';
                    RunObject = page "Inventory Periods";
                }
                action("Phys. Invt. Counting Periods")
                {
                    ApplicationArea = Warehouse, Basic, Suite;
                    Caption = 'Physical Invtory Counting Periods';
                    RunObject = page "Phys. Invt. Counting Periods";
                }
                action("Application Worksheet")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Application Worksheet';
                    RunObject = page "Application Worksheet";
                }
                group("Group51")
                {
                    Caption = 'Costing';

                    action("Adjust Item Costs/Prices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Adjust Item Costs/Prices';
                        RunObject = report "Adjust Item Costs/Prices";
                    }
                    action("Adjust Cost - Item Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Adjust Cost - Item Entries...';
                        RunObject = report "Adjust Cost - Item Entries";
                    }
                    action("Update Unit Cost...")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Update Unit Costs...';
                        RunObject = report "Update Unit Cost";
                    }
                    action("Post Inventory Cost to G/L")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Inventory Cost to G/L';
                        RunObject = report "Post Inventory Cost to G/L";
                    }
                }
                group("Group52")
                {
                    Caption = 'Journals';

                    action("Item Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Journals';
                        RunObject = page "Item Journal";
                    }
                    action("Item Reclass. Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Reclassification Journals';
                        RunObject = page "Item Reclass. Journal";
                    }
                    action("Phys. Inventory Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Physical Inventory Journals';
                        RunObject = page "Phys. Inventory Journal";
                    }
                    action("Revaluation Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Revaluation Journals';
                        RunObject = page "Revaluation Journal";
                    }
                }
                group("Group53")
                {
                    Caption = 'Reports';

                    action("Inventory Valuation")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Valuation';
                        RunObject = report "Inventory Valuation";
                    }
                    action("Inventory Valuation - WIP")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Production Order - WIP';
                        RunObject = report "Inventory Valuation - WIP";
                    }
                    action("Inventory - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - List';
                        RunObject = report "Inventory - List";
                    }
                    action("Invt. Valuation - Cost Spec.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invt. Valuation - Cost Spec.';
                        RunObject = report "Invt. Valuation - Cost Spec.";
                    }
                    action("Item Age Composition - Value")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Age Composition - Value';
                        RunObject = report "Item Age Composition - Value";
                    }
                    action("Item Register - Value")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Register - Value';
                        RunObject = report "Item Register - Value";
                    }
                    action("Physical Inventory List")
                    {
                        ApplicationArea = Warehouse;
                        Caption = 'Physical Inventory List';
                        RunObject = report "Phys. Inventory List";
                    }
                    action("Status")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Status';
                        RunObject = report "Status";
                    }
                    action("Cost Shares Breakdown")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Cost Shares Breakdown';
                        RunObject = report "Cost Shares Breakdown";
                    }
                    action("Item Register - Quantity")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Register - Quantity';
                        RunObject = report "Item Register - Quantity";
                    }
                    action("Item Dimensions - Detail")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Detail';
                        RunObject = report "Item Dimensions - Detail";
                    }
                    action("Item Dimensions - Total")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Total';
                        RunObject = report "Item Dimensions - Total";
                    }
                    action("Inventory - G/L Reconciliation")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - G/L Reconciliation';
                        RunObject = page "Inventory - G/L Reconciliation";
                    }
                }
                group("Group54")
                {
                    Caption = 'Setup';

                    action("Inventory Posting Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Posting Setup';
                        RunObject = page "Inventory Posting Setup";
                    }
                    action("Inventory Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Setup';
                        RunObject = page "Inventory Setup";
                    }
                    action("Item Charges")
                    {
                        ApplicationArea = ItemCharges;
                        Caption = 'Item Charges';
                        RunObject = page "Item Charges";
                    }
                    action("Item Categories")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Categories';
                        RunObject = page "Item Categories";
                    }
                    action("Rounding Methods")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rounding Methods';
                        RunObject = page "Rounding Methods";
                        AccessByPermission = tabledata Resource = R;
                    }
                    action("Analysis Types")
                    {
                        ApplicationArea = SalesAnalysis, PurchaseAnalysis, InventoryAnalysis;
                        Caption = 'Analysis Types';
                        RunObject = page "Analysis Types";
                    }
                    action("Inventory Analysis Report")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Inventory Analysis Reports';
                        RunObject = page "Analysis Report Inventory";
                    }
                    action("Analysis View Card")
                    {
                        ApplicationArea = InventoryAnalysis, Dimensions;
                        Caption = 'Inventory Analysis by Dimensions';
                        RunObject = page "Analysis View List Inventory";
                    }
                    action("Analysis Column Templates")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Invt. Analysis Column Templates';
                        RunObject = report "Run Invt. Analysis Col. Temp.";
                    }
                    action("Analysis Line Templates")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Invt. Analysis Line Templates';
                        RunObject = report "Run Invt. Analysis Line Temp.";
                    }
                }
            }
            group("Finance Transaction List")
            {
                group("Open Documents")
                {
                    action("Request for Payment Form")
                    {
                        RunObject = page "Payment Form Requests";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Payment Voucher")
                    {
                        RunObject = Page "Payment Vouchers";
                    }
                    action(Receipts)
                    {
                        RunObject = Page Receipts;
                    }
                    action("Petty Cash List")
                    {
                        RunObject = Page "Petty Cash List";
                    }
                    action("Petty Cash Surrender")
                    {
                        RunObject = page "Petty Cash Surrenders";
                    }
                    action("Staff Claim")
                    {
                        RunObject = page "Staff Claim List";
                    }
                    action("Interbank Transfers")
                    {
                        RunObject = page "InterBank Transfer List";
                    }
                    action("Mpesa Entries")
                    {
                        RunObject = page "Mpesa Entries";
                    }
                    action("Bank Entries")
                    {
                        RunObject = page "Coop Bank Entries";
                    }
                }
                group("Documents Pending Approval")
                {
                    action("Pending Payment Vouchers")
                    {
                        RunObject = page "Pending Payment Vouchers1";
                    }
                    action("Pending Imprests")
                    {
                        RunObject = page "Pending Imprests";
                    }
                    action("Pending Imprest Surrenders")
                    {
                        RunObject = page "Pending Imprest Surrenders";
                    }
                    action("Pending Staff Claim")
                    {
                        RunObject = page "Pending Staff Claim List";
                    }
                    action("Pending Petty Cash")
                    {
                        RunObject = page "Pending Petty Cash List";
                    }
                    action("Pending Petty Cash Surrenders ")
                    {
                        RunObject = page "Pending Petty Cash Surrenders";
                    }
                    action("Pending InterBank Transfers")
                    {
                        RunObject = page "Pending InterBank Transfer";
                    }
                }
                group("Document Approved List")
                {
                    action("Approved Payment Vouchers")
                    {
                        RunObject = page "Approved Payment Vouchers1";
                    }
                    action("Request for Payment Form sent to finance")
                    {
                        RunObject = page "Payment Form Requests";
                        // RunPageLink = Status = filter(Released), "PV Created" = const(false);
                        RunPageLink = Status = filter(Released);
                    }
                    action("Approved Petty Cash List")
                    {
                        RunObject = Page "Approved Petty Cash";
                    }
                    action("Approved Petty Cash Surrender")
                    {
                        RunObject = page "Approved Petty Cash Surrenders";
                    }
                    action("Budget Approved List")
                    {
                        RunObject = Page "Budget Approved List";
                    }
                    action("Approved Imprests ")
                    {
                        RunObject = Page "Approved Imprests";
                    }
                    action("Approved Imprest Surrenders ")
                    {
                        RunObject = Page "Approved Imprest Surrenders";
                    }
                    action("Approved Staff Claim ")
                    {
                        RunObject = Page "Approved Staff Claim";
                    }
                    action("Purchase Request Approved ")
                    {
                        RunObject = Page "Purchase Request Approved";
                    }
                    action("Imprest Deductions ")
                    {
                        RunObject = page "Imprest Deduction";
                    }
                    action("Approved InterBank Transfers")
                    {
                        RunObject = page "Approved InterBank Transfer";
                    }
                }
                group("Posted Document List")
                {
                    action("Posted PVs")
                    {
                        RunObject = page "Posted Payment Vouchers1";
                    }
                    action("Archived Payment Request Forms")
                    {
                        RunObject = page "Payment Form Requests";
                        // RunPageLink = Status = filter(Released), "PV Created" = const(true);
                        RunPageLink = Status = filter(Released);
                    }
                    action("Posted Receipts")
                    {
                        RunObject = Page "Posted Receipts";
                    }
                    action("Posted Petty Cash")
                    {
                        RunObject = Page "Posted Petty cash";
                    }
                    action("Posted Petty Cash Surrenders")
                    {
                        RunObject = Page "Posted Petty Cash Surrenders";
                    }
                    action("Posted Credit Memos1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Credit Memos';
                        RunObject = page "Posted Purchase Credit Memos";
                    }
                    action("Posted Purchase Invoices12")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Invoices';
                        RunObject = page "Posted Purchase Invoices";
                    }
                    action("Posted Purchase Receipts")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Posted Purchase Receipts';
                        RunObject = page "Posted Purchase Receipts";
                    }
                    action("Posted Return Shipments")
                    {
                        ApplicationArea = PurchReturnOrder;
                        Caption = 'Posted Purchase Return Shipments';
                        RunObject = page "Posted Return Shipments";
                    }
                    action("Posted Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Sales Invoices';
                        RunObject = page "Posted Sales Invoices";
                    }
                    action("Posted Sales Shipments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Sales Shipments';
                        RunObject = page "Posted Sales Shipments";
                    }
                    action("Posted Credit Memos")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Sales Credit Memos';
                        RunObject = page "Posted Sales Credit Memos";
                    }
                    action("Posted Return Receipts")
                    {
                        ApplicationArea = SalesReturnOrder;
                        Caption = 'Posted Return Receipts';
                        RunObject = page "Posted Return Receipts";
                    }
                    action("Posted Imprest Surrenders")
                    {
                        ApplicationArea = SalesReturnOrder;
                        RunObject = page "Posted Imprest Surrenders";
                    }
                    action("Posted Staff Claim ")
                    {
                        RunObject = Page "Posted Staff Claim";
                    }
                    action("Posted Imprests")
                    {
                        ApplicationArea = SalesReturnOrder;
                        RunObject = page "Posted Imprests";
                    }
                    action("Posted interbank transfers")
                    {
                        ApplicationArea = SalesReturnOrder;
                        RunObject = page "Posted InterBank Transfer";
                    }
                    action("Payments List - All")
                    {
                        ApplicationArea = SalesReturnOrder;
                        RunObject = page "Payments List - All";
                    }
                }
            }
            group("Finance Activities")
            {
                action("G/L Budgets")
                {
                    RunObject = Page "G/L Budget Names";
                }
                action("Proposed Budget List")
                {
                    RunObject = Page "Proposed G/L Budget Names";
                }
                action("Budget Approval List")
                {
                    RunObject = Page "Budget Approval List";
                }
                action("Budget vs Commitments")
                {
                    RunObject = report "Votebook Summary";
                }
                action("Budget Report")
                {
                    RunObject = report Budget;
                }
                action("Budget Utilization")
                {
                    RunObject = report "Budget Utilization";
                }
            }
            group("Group55")
            {
                Caption = 'Setup';

                action("General Posting Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Posting Setup';
                    RunObject = page "General Posting Setup";
                }
                action("Incoming Documents Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Documents Setup';
                    RunObject = page "Incoming Documents Setup";
                }
                action("Accounting Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Periods';
                    RunObject = page "Accounting Periods";
                }
                action("Standard Text Codes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Standard Text Codes';
                    RunObject = page "Standard Text Codes";
                }
                action("No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'No. Series';
                    RunObject = page "No. Series";
                }
                group("Group56")
                {
                    Caption = 'VAT';

                    action("Posting Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Posting Setup';
                        RunObject = page "VAT Posting Setup";
                    }
                    action("VAT Clauses")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Clauses';
                        RunObject = page "VAT Clauses";
                    }
                    action("VAT Change Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Rate Change Setup';
                        RunObject = page "VAT Rate Change Setup";
                    }
                    action("VAT Statement Templates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Statement Templates';
                        RunObject = page "VAT Statement Templates";
                    }
                    action("VAT Reports Configuration")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Reports Configuration';
                        RunObject = page "VAT Reports Configuration";
                    }
                }
                group("Group57")
                {
                    Caption = 'Intrastat';

                    action("Intrastat Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Intrastat Setup';
                        RunObject = page "Intrastat Setup";
                    }
                    action("Tariff Numbers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tariff Numbers';
                        RunObject = page "Tariff Numbers";
                    }
                    action("Transaction Types")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transaction Types';
                        RunObject = page "Transaction Types";
                    }
                    action("Transaction Specifications")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transaction Specifications';
                        RunObject = page "Transaction Specifications";
                    }
                    action("Transport Methods")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transport Methods';
                        RunObject = page "Transport Methods";
                    }
                    action("Entry/Exit Points")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Entry/Exit Points';
                        RunObject = page "Entry/Exit Points";
                    }
                    action("Areas")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Areas';
                        RunObject = page "Areas";
                    }
                    action("Intrastat Journal Templates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Intrastat Journal Templates';
                        RunObject = page "Intrastat Journal Templates";
                    }
                }
                group("Group58")
                {
                    Caption = 'Intercompany';

                    action("Intercompany Setup")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Setup';
                        RunObject = page "Intercompany Setup";
                    }
                    action("Partner Code")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Partners';
                        RunObject = page "IC Partner List";
                    }
                    action("Chart of Accounts2")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Chart of Accounts';
                        RunObject = page "IC Chart of Accounts";
                    }
                    action("Dimensions")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Intercompany Dimensions';
                        RunObject = page "IC Dimensions";
                    }
                }
                group("Group59")
                {
                    Caption = 'Dimensions';

                    action("Dimensions1")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions';
                        RunObject = page "Dimensions";
                    }
                    action("Analyses by Dimensions1")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Analysis by Dimensions';
                        RunObject = page "Analysis View List";
                    }
                    action("Dimension Combinations")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimension Combinations';
                        RunObject = page "Dimension Combinations";
                    }
                    action("Default Dimension Priorities")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Default Dimension Priorities';
                        RunObject = page "Default Dimension Priorities";
                    }
                }
                group("Group60")
                {
                    Caption = 'Trail Codes';

                    action("Source Codes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Source Codes';
                        RunObject = page "Source Codes";
                    }
                    action("Reason Codes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Reason Codes';
                        RunObject = page "Reason Codes";
                    }
                    action("Source Code Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Source Code Setup';
                        RunObject = page "Source Code Setup";
                    }
                }
                group("Group61")
                {
                    Caption = 'Posting Groups';

                    action("General Business")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Gen. Business Posting Groups';
                        RunObject = page "Gen. Business Posting Groups";
                    }
                    action("Gen. Product Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Product Posting Groups';
                        RunObject = page "Gen. Product Posting Groups";
                    }
                    action("Customer Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Posting Groups';
                        RunObject = page "Customer Posting Groups";
                    }
                    action("Vendor Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Posting Groups';
                        RunObject = page "Vendor Posting Groups";
                    }
                    action("Bank Account")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Posting Groups';
                        RunObject = page "Bank Account Posting Groups";
                    }
                    action("Inventory Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Posting Groups';
                        RunObject = page "Inventory Posting Groups";
                    }
                    action("FA Posting Groups")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Posting Groups';
                        RunObject = page "FA Posting Groups";
                    }
                    action("Business Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Business Posting Groups';
                        RunObject = page "VAT Business Posting Groups";
                    }
                    action("Product Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Product Posting Groups';
                        RunObject = page "VAT Product Posting Groups";
                    }
                }
                group(Setups)
                {
                    action(CashSetup)
                    {
                        Caption = 'Cash Management Setup';
                        Image = Setup;
                        RunObject = page "Cash Management Setups";
                    }
                    action("Imprest Types")
                    {
                        RunObject = page "Imprest Types";
                    }
                    action("Payment Types")
                    {
                        RunObject = page "Payment Types";
                    }
                    action("Petty Cash Types")
                    {
                        RunObject = page "Petty Cash Types";
                    }
                    action("Receipt Types")
                    {
                        RunObject = page "Receipt Types";
                    }
                    action("Advance Types")
                    {
                        RunObject = page "Advance Types";
                    }
                    action("Claim Types")
                    {
                        RunObject = page "Claim Types";
                    }
                    action("Expense Codes")
                    {
                        RunObject = page "Expense Codes";
                    }
                    action("Destination Codes")
                    {
                        RunObject = page "Destination Code";
                    }
                    action("User Posting Template")
                    {
                        RunObject = page "User Posting Template";
                    }
                    action("Banker Cheque Register")
                    {
                        RunObject = page "Banks Cheque Register";
                    }
                    action("Cash Office User Template")
                    {
                        RunObject = page "Cash Office User Template";
                    }
                    action("Mpesa Integration Setup")
                    {
                        RunObject = page "Mpesa Integration Setup";
                    }
                }
                group("Payroll-Export to Bank")
                {
                    action("Export To Bank-Employees")
                    {
                        RunObject = xmlport "Payroll Export To Bank";
                    }
                }
            }
            group("Payment Files")
            {
                action("Payment File Generations")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "EFT File Generations";
                    ToolTip = 'Executes the Payment File Generations action';
                }
                action("Payment File Generations Posted")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "EFT File Generations Posted";
                    ToolTip = 'Executes the Payment File Generations Posted action';
                }
            }
            group("Self service")
            {
                group(Imprest)
                {
                    action(Imprests)
                    {
                        RunObject = Page "Imprests-General";
                    }
                    action("Imprest Surrenders ")
                    {
                        RunObject = Page "Imprest Surrenders-General";
                    }
                    action("Staff Claim List ")
                    {
                        RunObject = Page "Staff Claim List-General";
                    }
                    action("Petty Cash")
                    {
                        RunObject = page "Petty Cash List-General";
                    }
                    action("Petty Cash Surrenders")
                    {
                        RunObject = page "Petty Cash Surrenders-Gen";
                    }
                }
                group(Requistions)
                {
                    action("Purchase Request List ")
                    {
                        RunObject = Page "Purchase Request List-General";
                    }
                    action("Store Request List ")
                    {
                        RunObject = Page "Store Request List-General";
                    }
                    action("Request for payment forms ")
                    {
                        RunObject = page "Payment Form Requests General";
                    }
                    action("Transport Request")
                    {
                        RunObject = Page "Transport requests -General";
                    }
                }
                group("Leave Process")
                {
                    action("Leave Applications List")
                    {
                        RunObject = Page "Self-Service Leave Application";
                    }
                    action("Open Reliever Approvals")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Self Service Application 1";
                        //RunPageLink = Status = filter("Reliever Open");
                    }
                    action("Reliever Approved Leave Applications")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Self-Service Leave Application";
                        //  RunPageLink = Status = filter("Reliever Approved" | "Pending Approval");
                    }
                    action("Leave Planner")
                    {
                        RunObject = page "Self Service Leave Planner";
                    }
                }
                group("Training")
                {
                    action("Training Requests List ")
                    {
                        RunObject = Page "Training Request List-General";
                    }
                    action("Post Training Evaluation List")
                    {
                        ApplicationArea = all;
                        RunObject = page "Post Training List";
                    }
                }
                group("Performance Management")
                {
                    action("Target Setup List ~ New")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "New Targets List";
                    }
                    action("Target Under Review")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Targets Under Review";
                    }
                    action("Approved Targets List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Approved Targets List";
                    }
                    action("Appraisal List - New")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Appraisal List";
                    }
                    action("Appraisal List - Pending Approval")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Appraisal List - Pending";
                        RunPageLink = Status = CONST("Pending Approval");
                    }
                    action("Appraisal Periods")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Appraisal Periods";
                    }
                    action("Managerial Core Values/competence")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Managerial Core Values Setup";
                    }
                    action("Core Values/Competece")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Core Value/Competence Setup";
                    }
                    action("Rating Scale")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Rating Scale List";
                    }
                    action("Appraisal Preamble Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Appraisal Preamble Setup";
                    }
                }
                group("Reports")
                {
                    action(Payslip)
                    {
                        Caption = 'My Payslip';
                        RunObject = report "New Payslipx-Self Service";
                    }
                    action(P9)
                    {
                        Caption = 'My P9';
                        RunObject = report "P9A Report-Self Service";
                    }
                    action(CustomerStatement)
                    {
                        Caption = 'My Customer Statement';
                        RunObject = report "Customer Statement";
                    }
                }
                action("Incident Reporting")
                {
                    RunObject = page "Incident Reports General";
                }
                action("Visitor's Interaction Books")
                {
                    RunObject = page "Enquiries General";
                }
            }
        }
        area(processing)
        {
        }
        area(reporting)
        {
            group("Employee Payroll Reports")
            {
                group("Bank Details")
                {
                    action("Employee Bank Details")
                    {
                        Image = "Report";
                        RunObject = Report "Employee Bank Details";
                    }
                }
                group("Management Reports ")
                {
                    Caption = 'Management Reports';

                    action("New Payslips ")
                    {
                        Image = NewBank;
                        RunObject = Report "New Payslipx";
                    }
                    action("Earnings Report")
                    {
                        Image = "Report";
                        RunObject = Report Earnings;
                    }
                    action("Deduction Report")
                    {
                        Caption = 'Deductions Report';
                        Image = "Report";
                        RunObject = Report Deductions;
                    }
                    action("Net Pay Report")
                    {
                        Image = "Report";
                        RunObject = Report "Net Pay Bank Transfer";
                    }
                    action("Employee Below Pay")
                    {
                        Image = "Report";
                        RunObject = Report "Employee Below Pay";
                    }
                    action("Employee List ")
                    {
                        Image = "Report";
                        RunObject = Report "Employee - List";
                    }
                    action("SACCO  Reports")
                    {
                        Image = "Report";
                        RunObject = Report "Sacco Report";
                    }
                }
                group("Statutory Reports")
                {
                    Caption = 'Statutory Reports';

                    action("Monthly Payee Report ")
                    {
                        Image = "Report";
                        RunObject = Report "Monthly PAYE Reportx";
                    }
                    action("NSSF Reporting ")
                    {
                        Image = "Report";
                        RunObject = Report "NSSF Reporting";
                    }
                    action("NHIF ")
                    {
                        Image = Migration;
                        RunObject = Report NHIF;
                    }
                    action(HELBReport)
                    {
                        Caption = 'HELB Report';
                        Image = "Report";
                        ApplicationArea = Basic, Suite;
                        RunObject = report HELB;
                    }
                    action(NITAReport)
                    {
                        Caption = 'NITA Report';
                        Image = "Report";
                        ApplicationArea = Basic, Suite;
                        RunObject = report NITA;
                    }
                    action("Pension Report")
                    {
                        Image = "Report";
                        RunObject = Report "Pension Report";
                    }
                }
                group("Annual Statutory Reports")
                {
                    Caption = 'Annual Statutory Reports';

                    action("P9A Report ")
                    {
                        Image = ResourcePlanning;
                        RunObject = Report "P9A Report";
                    }
                    action(P10Report)
                    {
                        Caption = 'P10 Report';
                        Image = "Report";
                        RunObject = Report P10;
                    }
                }
                group("Reconciliation Reports")
                {
                    Caption = 'Reconciliation Reports';

                    action("Monthly Difference Report")
                    {
                        RunObject = Report "Payroll Reconciliation";
                    }
                    action("Employees Removed ")
                    {
                        Image = ChangeCustomer;
                        RunObject = Report "Employees Removed";
                    }
                    action("Summary By Centre")
                    {
                        RunObject = Report "Summary By Center_1";
                    }
                    action("Payroll Reconciliation Summary")
                    {
                        Image = Reconcile;
                        RunObject = Report "Payroll Reconciliation Summary";
                    }
                    action("Master Roll Report")
                    {
                        RunObject = Report "Master Roll Report";
                    }
                }
                // group("Leave Reports")
                // {
                //     action("leave balance")
                //     {
                //         Caption = 'Leave Balances';
                //         RunObject = Report "Leave Balance";
                //     }
                //     action("leave Statement")
                //     {
                //         Caption = 'Leave Statements';
                //         RunObject = Report "HR Staff Leave Statement";
                //     }
                // }
                group("Imprest Deductions")
                {
                    Caption = 'Imprest Deduction';

                    action("Imprest Deduction")
                    {
                        RunObject = page "Imprest Deduction";
                    }
                }
            }
            group("Board Payroll Reports")
            {
                group("Bank-Details")
                {
                    action("Board Bank Details")
                    {
                        Image = "Report";
                        RunObject = Report "Trustee Bank Details";
                    }
                }
                group("Management-Reports ")
                {
                    Caption = 'Management Reports';

                    action("Board Payslips ")
                    {
                        Image = NewBank;
                        RunObject = Report "Trustee Payslipx";
                    }
                    action("Earnings -Report")
                    {
                        Caption = 'Earnings Report';
                        Image = "Report";
                        RunObject = Report "Trustee Earnings";
                    }
                    action("Deduction-Report")
                    {
                        Caption = 'Deductions Report';
                        Image = "Report";
                        RunObject = Report TrusteeDeductions;
                    }
                    action("Net- Pay Report")
                    {
                        Caption = 'Net Pay report';
                        Image = "Report";
                        RunObject = Report "Trustee Net Pay Bank Transfer";
                    }
                    action("Board Below Pay")
                    {
                        Image = "Report";
                        RunObject = Report "Trustee Below Pay";
                    }
                    action("Board List ")
                    {
                        Image = "Report";
                        RunObject = Report "Trustee - List";
                    }
                    action("SACCO Reports")
                    {
                        Image = "Report";
                        RunObject = Report "Trustee Sacco Report";
                    }
                }
                group("Statutory-Reports")
                {
                    Caption = 'Statutory Reports';

                    action("Monthly Payee - Report ")
                    {
                        Caption = 'Montly payee report';
                        Image = "Report";
                        RunObject = Report "Trustee Monthly PAYE Report";
                    }
                    action("NSSF-Reporting ")
                    {
                        Caption = 'NSSF reporting';
                        Image = "Report";
                        RunObject = Report "Trustee NSSF Reporting";
                    }
                    action(NHIF)
                    {
                        Image = Migration;
                        RunObject = Report TrusteeNHIF;
                    }
                    action("NITA-Report")
                    {
                        Caption = 'NITA Report';
                        Image = "Report";
                        ApplicationArea = Basic, Suite;
                        RunObject = report TrusteeNITA;
                    }
                    action("HELB Report")
                    {
                        Caption = 'HELB Report';
                        Image = "Report";
                        ApplicationArea = Basic, Suite;
                        RunObject = report TrusteeHELB;
                    }
                    action("Pension-Report")
                    {
                        Caption = 'Pension Report';
                        Image = "Report";
                        RunObject = Report "Trustee Pension Report";
                    }
                }
                group("Annual-Statutory Reports")
                {
                    Caption = 'Annual Statutory Reports';

                    action("P9A-Report ")
                    {
                        Caption = 'P9A Report';
                        Image = ResourcePlanning;
                        RunObject = Report "P9A Report-Trustees";
                    }
                    action("P10-Report")
                    {
                        Caption = 'P10 Report';
                        Image = "Report";
                        RunObject = Report TrusteeP10;
                    }
                }
                group("Reconciliation-Reports")
                {
                    Caption = 'Reconciliation Reports';

                    action("Monthly-Difference Report")
                    {
                        RunObject = Report "Trustee Payroll Reconciliation";
                    }
                    action("Board-Removed ")
                    {
                        Caption = 'Board members removed';
                        Image = ChangeCustomer;
                        RunObject = Report "Trustees Removed";
                    }
                    action("Summary-By Centre")
                    {
                        Caption = 'Summary By Centre';
                        RunObject = Report "Trustee Summary By Center_1";
                    }
                    action("Payroll- Reconciliation Summary")
                    {
                        Caption = 'Payroll Reconciliation Summary';
                        Image = Reconcile;
                        RunObject = Report "Trustee Payroll Rec Summary";
                    }
                    action("Master-Roll Report-Old")
                    {
                        Caption = 'Master Roll Report';
                        RunObject = Report "Master Roll Report-Trustees";
                        Visible = false;
                    }
                    action("Master Roll-Board")
                    {
                        Caption = 'Master Roll Report';
                        RunObject = report "Master Roll-Board Members";
                    }
                }
                action("PAYE Report-Trustees")
                {
                    Caption = 'PAYE Report - Board Members';
                    RunObject = report "PAYE Report - Primary";
                }
            }
        }
    }
}

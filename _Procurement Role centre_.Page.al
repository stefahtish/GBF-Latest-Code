page 50766 "Procurement Role centre"
{
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
            part("General Management Cues"; "General Management Cues")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Procurement Management Cue"; "Procurement Management Cues")
            {
                ApplicationArea = Basic, Suite;
            }
            group(Control1900724808)
            {
                ShowCaption = false;

                part(Control1907662708; "Purchase Agent Activities")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control1902476008; "My Vendors")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;

                part(Control25; "Purchase Performance")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control37; "Purchase Performance")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                part(Control21; "Inventory Performance")
                {
                    ApplicationArea = Basic, Suite;
                }
                part(Control44; "Inventory Performance")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = Basic, Suite;
                }
                systempart(Control43; MyNotes)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part("Approval Cues"; "Approval Cues")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(reporting)
        {
            action("Vendor - T&op 10 List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Supplier - T&op 10 List';
                Image = "Report";
                RunObject = Report "Vendor - Top 10 List";
                ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
            }
            action("Vendor/&Item Purchases")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Supplier/&Item Purchases';
                Image = "Report";
                RunObject = Report "Vendor/Item Purchases";
                ToolTip = 'View a list of item entries for each vendor in a selected period.';
            }
            separator(Action28)
            {
            }
            action("Inventory - &Availability Plan")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory - &Availability Plan';
                Image = ItemAvailability;
                RunObject = Report "Inventory - Availability Plan";
                ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
            }
            action("Inventory &Purchase Orders")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory &Purchase Orders';
                Image = "Report";
                RunObject = Report "Inventory Purchase Orders";
                ToolTip = 'View a list of items on order from vendors. The report also shows the expected receipt date and the quantity and amount on back orders. The report can be used, for example, to see when items should be received and whether a reminder of a back order should be issued.';
            }
            action("Inventory - &Vendor Purchases")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory - &Vendor Purchases';
                Image = "Report";
                RunObject = Report "Inventory - Vendor Purchases";
                ToolTip = 'View a list of the vendors that your company has purchased items from within a selected period. It shows invoiced quantity, amount and discount. The report can be used to analyze a company''s item purchases.';
            }
            action("Inventory &Cost and Price List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory &Cost and Price List';
                Image = "Report";
                RunObject = Report "Inventory Cost and Price List";
                ToolTip = 'View price information for your items or stockkeeping units, such as direct unit cost, last direct cost, unit price, profit percentage, and profit.';
            }
        }
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
                RunPageLink = Procurement = const(true);
            }
            action(PurchaseOrders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(PurchaseOrdersPendConf)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pending Confirmation';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Open));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action(PurchaseOrdersPartDeliv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Partially Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Released), Receive = FILTER(true), "Completely Received" = FILTER(false));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action("Purchase Quotes")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Quotes';
                RunObject = Page "Purchase Quotes";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }
            action("Blanket Purchase Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Blanket Purchase Orders';
                RunObject = Page "Blanket Purchase Orders";
                ToolTip = 'Use blanket purchase orders as a framework for a long-term agreement between you and your vendors to buy large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a purchase order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
            }
            action("Purchase Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Purchase Return Orders")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Purchase Return Orders';
                RunObject = Page "Purchase Return Order List";
                ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
            }
            action("Purchase Credit Memo")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Credit Memos';
                RunObject = Page "Purchase Credit Memos";
                ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
            }
            action("Assembly Orders")
            {
                ApplicationArea = Assembly;
                Caption = 'Assembly Orders';
                RunObject = Page "Assembly Orders";
                ToolTip = 'View ongoing assembly orders.';
            }
            action("Sales Orders")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
            }
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Item)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Catalog Items")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Catalog Items';
                Image = NonStockItem;
                RunObject = Page "Catalog Item List";
                ToolTip = 'View the list of items that you do not carry in inventory. ';
            }
            action("Stockkeeping Unit")
            {
                ApplicationArea = Warehouse;
                Caption = 'Stockkeeping Units';
                Image = SKU;
                RunObject = Page "Stockkeeping Unit List";
                ToolTip = 'Open the list of item SKUs to view or edit instances of item at different locations or with different variants. ';
            }
            action("Purchase Analysis Reports")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Analysis Reports';
                RunObject = Page "Analysis Report Purchase";
                RunPageView = WHERE("Analysis Area" = FILTER(Purchase));
                ToolTip = 'Analyze the dynamics of your purchase volumes. You can also use the report to analyze your vendors'' performance and purchase prices.';
            }
            action("Inventory Analysis Reports")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Inventory Analysis Reports';
                RunObject = Page "Analysis Report Inventory";
                RunPageView = WHERE("Analysis Area" = FILTER(Inventory));
                ToolTip = 'Analyze the dynamics of your inventory according to key performance indicators that you select, for example inventory turnover. You can also use the report to analyze your inventory costs, in terms of direct and indirect costs, as well as the value and quantities of your different types of inventory.';
            }
            action("Item Journals")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Item), Recurring = CONST(false));
                ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
            }
            action(RequisitionWorksheets)
            {
                ApplicationArea = Planning;
                Caption = 'Requisition Worksheets';
                RunObject = Page "Req. Wksh. Names";
                RunPageView = WHERE("Template Type" = CONST("Req."), Recurring = CONST(false));
                ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
            }
            action(SubcontractingWorksheets)
            {
                ApplicationArea = Planning;
                Caption = 'Subcontracting Worksheets';
                RunObject = Page "Req. Wksh. Names";
                RunPageView = WHERE("Template Type" = CONST("For. Labor"), Recurring = CONST(false));
                ToolTip = 'Calculate the needed production supply, find the production orders that have material ready to send to a subcontractor, and automatically create purchase orders for subcontracted operations from production order routings.';
            }
            action("Standard Cost Worksheets")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Standard Cost Worksheets';
                RunObject = Page "Standard Cost Worksheet Names";
                ToolTip = 'Review or update standard costs. Purchasers, production or assembly managers can use the worksheet to simulate the effect on the cost of the manufactured or assembled item if the standard cost for consumption, production capacity usage, or assembly resource usage is changed. You can set a cost change to take effect on a specified date.';
            }
        }
        area(creation)
        {
            action("Purchase &Quote")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase &Quote';
                Image = Quote;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase quote, for example to reflect a request for quote.';
            }
            action("Purchase &Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase &Invoice';
                Image = NewPurchaseInvoice;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase invoice.';
            }
            action("Purchase &Order")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase &Order';
                Image = Document;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
            action("Purchase &Return Order")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Purchase &Return Order';
                Image = ReturnOrder;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Return Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase return order to return received items.';
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("&Purchase Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Purchase Journal';
                Image = Journals;
                RunObject = Page "Purchase Journal";
                ToolTip = 'Post purchase transactions directly to the general ledger. The purchase journal may already contain journal lines that are created as a result of related functions.';
            }
            action("Item &Journal")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = Page "Item Journal";
                ToolTip = 'Adjust the physical quantity of items on inventory.';
            }
            action("Order Plan&ning")
            {
                ApplicationArea = Planning;
                Caption = 'Order Plan&ning';
                Image = Planning;
                RunObject = Page "Order Planning";
                ToolTip = 'Plan supply orders order by order to fulfill new demand.';
            }
            separator(Action38)
            {
            }
            action("Requisition &Worksheet")
            {
                ApplicationArea = Planning;
                Caption = 'Requisition &Worksheet';
                Image = Worksheet;
                RunObject = Page "Req. Wksh. Names";
                RunPageView = WHERE("Template Type" = CONST("Req."), Recurring = CONST(false));
                ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
            }
            action("Pur&chase Prices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pur&chase Prices';
                Image = Price;
                RunObject = Page "Purchase Prices";
                ToolTip = 'View or set up different prices for items that you buy from the vendor. An item price is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.';
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
            }
        }
        area(sections)
        {
            group("Self service")
            {
                group(Payments)
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
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Petty Cash List-General";
                    }
                    action("Petty Cash Surrenders")
                    {
                        ApplicationArea = Basic, Suite;
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
                    action("Request for payment form")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Payment Form Requests General";
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
                        // RunPageLink = Status = filter("Reliever Approved" | "Pending Approval");
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
                action("Budget Approval List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Budget Approval List";
                }
                // action("Leave Applications List")
                // {
                //     RunObject = Page "Leave Application List-General";
                // }
                // action("Transport Request")
                // {
                //     RunObject = Page "Transport requests -General";
                // }
                // action("Training Requests List ")
                // {
                //     RunObject = Page "Training Request List-General";
                // }
                // action("Risk Identification")
                // {
                //     RunObject = page "Risks List General";
                // }
                // action("Risk Survey")
                // {
                //     RunObject = page "Risk Surveys General";
                // }
                // action("Incident Reporting")
                // {
                //     RunObject = page "Incident Reports General";
                // }
                // action("ICT Helpdesk")
                // {
                //     RunObject = page "ICT Support Incidences General";
                // }
                // action("Visitor's Interaction Books")
                // {
                //     RunObject = page "Enquiries General";
                // }
            }
            group(Plannings)
            {
                Caption = 'Planning';

                action("Procurement plans")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PriceWorksheet;
                    RunObject = Page "Procurement Plans";
                }
                // action("Budget VS Commitments Analysis")
                // {
                //     Image = PriceWorksheet;
                //     RunObject = Report "votebook summary";
                // }
            }
            group(Requisition)
            {
                Caption = 'Requisition';

                Group("Purchase Requisition")
                {
                    action("Purchase request list")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Purchase Request List";
                    }
                    action("Ammend Purchase requests")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Ammend Purchase Request List";
                    }
                    action("Purchase Req Pending Approval")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Purchase Request Pending";
                    }
                    action("Purchase Requests Approved")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = Page "Purchase Request Approved";
                    }
                    action("Purchase Requests Archived")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = Page "Archived Requisitions";
                    }
                    action("Purchase Request Fulfilled")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = page "Purch. Req Fulfilled";
                    }
                }
                Group("Store Requisition")
                {
                    action("Store Requests List")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = page "Store Request List-General";
                    }
                    action("Store Requests-Pending")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = page "Pending Store Request";
                    }
                    action("Store Requests-Approved")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = page "Approved Store Request";
                        RunPageLink = Posted = const(false);
                    }
                    action("Store Requests-Posted")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = page "Approved Store Request";
                        RunPageLink = Posted = const(true);
                    }
                    action("Store Requests-Archived")
                    {
                        ApplicationArea = Basic, Suite;
                        image = List;
                        RunObject = page "Archived Store Request List";
                    }
                }
                action("Request For Quotation")
                {
                    ApplicationArea = Basic, Suite;
                    Image = List;
                    RunObject = Page "Request for Quote & Order";
                }
                action("Tracking.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Procurement Status Check';
                    Image = List;
                    RunObject = Page "Purchase Request-Tracking";
                }
                action("Procurement Committees")
                {
                    ApplicationArea = All;
                    RunObject = page Committee;
                }
                action("Purchase Req")
                {
                    Caption = 'Purchase Requisition Report';
                    ApplicationArea = All;
                    RunObject = report "Purchase Req Report";
                }
            }
            group("Procurement Method")
            {
                Caption = 'Procurement Methods';

                group("Tender Management")
                {
                    group("Tenders")
                    {
                        action("Open Tenders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Tenders';
                            image = List;
                            RunObject = page "Tender List";
                            RunPageLink = Status = CONST(New), "Process Type" = CONST(Tender), "Tender Type" = const(Open), "Submitted To Portal" = const(false);
                        }
                        action("Restricted Tenders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Restricted Tenders';
                            Image = List;
                            RunObject = page "Restricted Tender List";
                            RunPageLink = Status = CONST(New);
                        }
                    }
                    action("Submitted to Portal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Submitted to Portal';
                        image = List;
                        RunObject = page "Tender List";
                        RunPageLink = Status = CONST(New), "Process Type" = CONST(Tender), "Tender Type" = const(Open), "Submitted To Portal" = const(true);
                    }
                    group("Tender Committees")
                    {
                        group("Tender Opening Committee")
                        {
                            Caption = 'Opening Committee';

                            action("Open Opening Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Committee Creation";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Opening Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Committee Creation";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("Tender Evaluation Committee")
                        {
                            Caption = 'Evaluation Committee';

                            action("Open Evalation Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Evaluation Committee';
                                image = List;
                                RunObject = page "Evaluation Committee Creation";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Evaluation Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Evaluation Committee Creation";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("Tender Inspection Committee")
                        {
                            Caption = 'Inspection and Acceptance Committee';

                            action("Open Inspection Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Inspection Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Inpection Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Inspection Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("Tender negotiation Committee")
                        {
                            Caption = 'Negotiation Committee';

                            action("Open negotiation Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Negotiation Committee Creation";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Negotiation Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Negotiation Committee Creation";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("Tender Special Committee")
                        {
                            Caption = 'complex and specialized contract implementation committee';

                            action("Open Special Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Specialized Committee Creation";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Special Tender Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Specialized Committee Creation";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                    }
                    group("Suppliers Evaluation")
                    {
                        group("Preliminary Evaluation")
                        {
                            action("Prelm Supplier Evaluation")
                            {
                                Caption = 'Preliminary Supplier Evaluation';
                                Image = List;
                                RunObject = Page "Supplier Evaluation List";
                                RunPageLink = Stage = const(Preliminary);
                                ToolTip = 'Executes the Preliminary Supplier Evaluation action';
                                ApplicationArea = All;
                            }
                            action("Submitted Preliminary Supplier Evaluation")
                            {
                                Image = List;
                                RunObject = Page "Supplier Evaluation List";
                                RunPageLink = Stage = const(Preliminary), Submitted = const(true);
                                ToolTip = 'Executes the Preliminary Supplier Evaluation action';
                                ApplicationArea = All;
                            }
                        }
                        // action("Preliminary Supplier Evaluation")
                        // {
                        //     Caption = 'Preliminary Supplier Evaluation';
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = Page "Supplier Evaluation List";
                        //     RunPageLink = Stage = const(Preliminary);
                        //     Image = List;
                        // }
                        group("Technical Evaluation")
                        {
                            action("Techn supplier evaluation")
                            {
                                Image = List;
                                Caption = 'Technical supplier evaluation';
                                RunObject = Page "Supplier Evaluation List";
                                RunPageLink = Stage = const(Technical);
                                ToolTip = 'Executes the Technical supplier evaluation action';
                                ApplicationArea = All;
                            }
                            action("Submitted Technical supplier evaluation")
                            {
                                Image = List;
                                RunObject = Page "Supplier Evaluation List";
                                RunPageLink = Stage = const(Technical), Submitted = const(true);
                                ToolTip = 'Executes the Technical supplier evaluation action';
                                ApplicationArea = All;
                            }
                        }
                        // action("Technical supplier evaluation")
                        // {
                        //     Caption = 'Technical Supplier Evaluation';
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = Page "Supplier Evaluation List";
                        //     RunPageLink = Stage = const(Technical);
                        //     Image = List;
                        // }
                        action("Supplier Evaluation-Pricing")
                        {
                            Visible = false;
                            Image = List;
                            RunObject = Page "Supplier Evaluation Approved";
                            RunPageLink = Stage = const(Prices);
                        }
                        action("Submitted Supplier Evaluation")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Supplier Evaluation List";
                            RunPageLink = Status = const(Approved);
                        }
                        action("Supplier Evaluation Setup")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Supplier Evaluation Score Setup';
                            Image = List;
                            RunObject = Page "Supplier Evaluation Setup";
                        }
                    }
                    /*group("Tender Opening")
                    {
                        action("Opening Open Tenders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open Tenders';
                            image = List;
                            RunObject = page "Tenders";
                            RunPageLink = Status = CONST(Opening);
                        }
                        action("Opening Restricted Tenders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Restricted Tenders';
                            Image = List;
                            RunObject = page "Restricted Tender List";
                            RunPageLink = Status = CONST(Opening);
                        }
                    }
                    group("Tender Evaluation")
                    {
                        Caption = 'Tender Evaluation';
                        action("Tender evaluation list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Tender Evaluation List";
                            RunPageLink = Status = filter(New), stage = const(Evaluation);
                        }
                        action("Tender evaluation list-Approved")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Tender Evaluation List";
                            RunPageLink = Status = const(Approved), stage = const(Evaluation);
                        }
                    }
                    group("Tender Negotiation")
                    {
                        action("Tender negotiation list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Tender Evaluation List";
                            RunPageLink = Status = filter(<> Approved), stage = const(Negotiation);
                        }
                        action("Tender negotiation list-Submitted")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Tender Evaluation List";
                            RunPageLink = Status = const(Approved), stage = const(Negotiation);
                        }
                    }*/
                    group("Tender Stages")
                    {
                        action("Opening Open Tenders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Opening Tenders';
                            image = List;
                            RunObject = page "Tenders";
                            RunPageLink = Stage = CONST(Opening);
                        }
                        action("Preliminary Tenders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Preliminary Tenders';
                            image = List;
                            RunObject = page "Tenders";
                            RunPageLink = Stage = CONST(Periliminary);
                        }
                        action("Technical Tenders")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Technical Tenders';
                            image = List;
                            RunObject = page "Tenders";
                            RunPageLink = Stage = CONST(Technical);
                        }
                        group("Financial Tenders")
                        {
                            action("Open Fin. Tenders")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open';
                                image = List;
                                RunObject = page "Tenders";
                                RunPageLink = Stage = CONST(Financial), Status = const(Opening);
                            }
                            action("Pending Fin. Tenders")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Pending Approval';
                                image = List;
                                RunObject = page "Tenders";
                                RunPageLink = Stage = CONST(Financial), Status = const("Pending Approval");
                            }
                            action("Approved Fin. Tenders")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved';
                                image = List;
                                RunObject = page "Tenders";
                                RunPageLink = Stage = CONST(Financial), Status = const(Approved);
                            }
                        }
                        action("Tender archive list")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Tender archive list';
                            image = List;
                            RunObject = page "Tenders";
                            RunPageLink = Stage = CONST(Archived), Status = const(Approved);
                        }
                    }
                    group("Specialized contract committee")
                    {
                        action("Specialized contract tender list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Tender Evaluation List";
                            RunPageLink = Status = filter(<> Approved), stage = const(Specialized);
                        }
                        action("Specialized contract tender -Submitted")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Tender Evaluation List";
                            RunPageLink = Status = const(Approved), stage = const(Specialized);
                        }
                    }
                    group("Tender Archives")
                    {
                        Visible = false;
                        Caption = 'Archives';

                        group("Tenders Under Evaluation")
                        {
                            action("Tender archive lists")
                            {
                                ApplicationArea = Basic, Suite;
                                Image = List;
                                RunObject = page "Tender Archive List";
                            }
                            action("Tender evaluation archive list")
                            {
                                ApplicationArea = Basic, Suite;
                                Image = List;
                                RunObject = Page "Tender Evaluation List-Archive";
                            }
                        }
                        group("Terminated Tenders")
                        {
                            action("Terminated Open Tenders")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Tenders';
                                image = List;
                                RunObject = page "Tender List";
                                RunPageLink = Status = CONST(Terminated);
                            }
                            action("Terminated Restricted Tenders")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Restricted Tenders';
                                Image = List;
                                RunObject = page "Restricted Tender List";
                                RunPageLink = Status = CONST(Terminated);
                            }
                        }
                    }
                    action("Supplier evaluation report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Prospective Suppliers";
                    }
                }
                group(Quotation)
                {
                    Caption = 'Request for Quotation';

                    group(Quotations)
                    {
                        action("Request for Quotation list ")
                        {
                            ApplicationArea = all;
                            Image = List;
                            RunObject = Page "Quotation List";
                            RunPageLink = Status = CONST(New);
                        }
                        action("Pending Quotation list ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quotation List";
                            RunPageLink = Status = CONST("Pending Approval");
                        }
                        action("Approved Quotation list ")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quotation List";
                            RunPageLink = Status = CONST(Approved), "Submitted To Portal" = const(false);
                        }
                        action("Approved Quotation")
                        {
                            Caption = 'Submitted to Portal';
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quotation List";
                            RunPageLink = Status = CONST(Approved), "Submitted To Portal" = const(true);
                        }
                    }
                    group("Quotation Committees")
                    {
                        group("RFQ Opening Committee")
                        {
                            Caption = 'Quotation Committee';

                            action("Open Opening RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Quotation Committee Creation";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Opening RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Quotation Committee Creation";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("RFQ Evaluation Committee")
                        {
                            Caption = 'Evaluation Committee';

                            //Visible = false;
                            action("Open Evalation RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Evaluation RFQ Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Evaluation RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Evaluation RFQ Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("RFQ Inspection Committee")
                        {
                            Caption = 'Inspection and Acceptance Committee';

                            action("Open Inspection RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "RFQ Inspection Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Inpection RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "RFQ Inspection Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("RFQ negotiation Committee")
                        {
                            Caption = 'Negotiation Committee';

                            action("Open negotiation RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Negotiation RFQ Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Negotiation RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Negotiation RFQ Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("RFQ Special Committee")
                        {
                            Caption = 'complex and specialized contract implementation committee';

                            action("Open Special RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Specialized RFQ Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Special RFQ Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Specialized RFQ Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                    }
                    group("Suppliers Evaluation1")
                    {
                        Caption = 'Suppliers Evaluation';

                        //changed
                        group("Opening")
                        {
                            action("Opening Supplier Evaluation1")
                            {
                                Caption = 'Opening Supplier Evaluation';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "Opening Evaluation List";
                                RunPageLink = Stage = const(Opening), Status = const(New);
                                Image = List;
                            }
                            action("Opening Supplier Evaluation23")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Submitted Opening Evaluation';
                                Image = List;
                                RunObject = Page "Opening Evaluation List";
                                RunPageLink = Stage = const(Opening), Status = const(Approved);
                            }
                        }
                        group("Preliminary")
                        {
                            action("Preliminary Supplier Evaluation1")
                            {
                                Caption = 'Preliminary Supplier Evaluation';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "Supplier Evaluation List3";
                                RunPageLink = Stage = const(Preliminary), Status = const(New);
                                Image = List;
                            }
                            action("Submitted Supplier Evaluation23")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Submitted Preliminary Evaluation';
                                Image = List;
                                RunObject = Page "Supplier Evaluation List3";
                                RunPageLink = Stage = const(Preliminary), Status = const(Approved);
                            }
                        }
                        group(Technical)
                        {
                            action("Technical Supplier Evaluation1")
                            {
                                Caption = 'Technical Supplier Evaluation';
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "Supplier Evaluation List3";
                                RunPageLink = Stage = const(Technical), Status = const(New);
                                Image = List;
                            }
                            action("Supplier Evaluation-Pricing1")
                            {
                                Visible = false;
                                Caption = 'Supplier Evaluation-Pricing';
                                Image = List;
                                RunObject = Page "Supplier Evaluation Approved";
                                RunPageLink = Stage = const(Prices);
                            }
                            action("Submitted Supplier Evaluation1")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Submitted Technical Evaluation';
                                Image = List;
                                RunObject = Page "Supplier Evaluation List3";
                                RunPageLink = Stage = const(Technical), Status = const(Approved);
                            }
                        }
                        action("Supplier Evaluation Setup1")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Supplier Evaluation Score Setup';
                            Image = List;
                            RunObject = Page "Supplier Evaluation Setup1";
                        }
                    }
                    group("Quote Opening")
                    {
                        Caption = 'Quote Stages';

                        action("Opening Quotations")
                        {
                            //Visible = false;
                            ApplicationArea = Basic, Suite;
                            //Caption = 'Open Quotation list';
                            image = List;
                            RunObject = page "Quotation List";
                            RunPageLink = Stage = CONST(Opening);
                        }
                        action("Preliminary Quotations")
                        {
                            ApplicationArea = Basic, Suite;
                            //Caption = 'Open Quotation list';
                            image = List;
                            RunObject = page "Quotation List";
                            RunPageLink = Stage = CONST(Periliminary);
                        }
                        action("Technical Quotations")
                        {
                            ApplicationArea = Basic, Suite;
                            //Caption = 'Open Quotation list';
                            image = List;
                            RunObject = page "Quotation List";
                            RunPageLink = Stage = CONST(Technical);
                        }
                        group("Financial Quoatations")
                        {
                            action("Financial Quotations")
                            {
                                ApplicationArea = Basic, Suite;
                                //Caption = 'Open Quotation list';
                                image = List;
                                RunObject = page "Quotation List";
                                RunPageLink = Stage = CONST(Financial);
                            }
                        }
                        action("Archived Quotations")
                        {
                            ApplicationArea = Basic, Suite;
                            //Caption = 'Open Quotation list';
                            image = List;
                            RunObject = page "Quotation List";
                            RunPageLink = Stage = CONST(Archived);
                        }
                    }
                    group("Quote Evaluation")
                    {
                        Visible = false;
                        Caption = 'Quote Evaluation';

                        action("Quote evaluation list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quote Evaluation List";
                            RunPageLink = "Quote Generated" = const(false), stage = const(Evaluation);
                        }
                        action("Quote evaluation archive list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quote Evaluation List";
                            RunPageLink = "Quote Generated" = const(true), stage = const(Evaluation);
                        }
                    }
                    group("Quote Negotiation")
                    {
                        action("Quote negotiation list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quote Evaluation List";
                            RunPageLink = Status = filter(<> Approved), stage = const(Negotiation);
                        }
                        action("Quote negotiation list-Submitted")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quote Evaluation List";
                            RunPageLink = Status = const(Approved), stage = const(Negotiation);
                        }
                    }
                    group("Specialized Quote contract committee")
                    {
                        action("Specialized contract Quote list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quote Evaluation List";
                            RunPageLink = Status = filter(<> Approved), stage = const(Specialized);
                        }
                        action("Specialized contract Quote Submitted")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quote Evaluation List";
                            RunPageLink = Status = const(Approved), stage = const(Specialized);
                        }
                    }
                    group("RFQ archives")
                    {
                        Caption = 'Archives';

                        action("Approved Quotation list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "Quotation List-Archive";
                            RunPageLink = Status = CONST(Approved);
                        }
                    }
                }
                group("Request for Proposal")
                {
                    Group("Request for Proposal list")
                    {
                        action("RFP List")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = page "RFP List";
                            RunPageLink = Status = CONST(New);
                        }
                    }
                    group("RFP Committees")
                    {
                        group("RFP Opening Committee")
                        {
                            Caption = 'Opening Committee';

                            action("Open Opening RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "RFP Committee Creation";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Opening RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "RFP Committee Creation";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("RFP Evaluation Committee")
                        {
                            Caption = 'Evaluation Committee';

                            action("Open Evalation RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Evaluation RFP Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Evaluation RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Evaluation RFP Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("RFP Inspection Committee")
                        {
                            Caption = 'Inspection and Acceptance Committee';

                            action("Open Inspection RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "RFP Inspection Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Inpection RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "RFP Inspection Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("RFP negotiation Committee")
                        {
                            Caption = 'Negotiation Committee';

                            action("Open negotiation RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Negotiation RFP Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Negotiation RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Negotiation RFP Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("RFP Special Committee")
                        {
                            Caption = 'complex and specialized contract implementation committee';

                            action("Open Special RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Specialized RFP Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Special RFP Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Specialized RFP Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                    }
                    group("Suppliers Evaluation2")
                    {
                        Caption = 'Suppliers Evaluation';

                        action("Preliminary Supplier Evaluation2")
                        {
                            Visible = false;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Preliminary Supplier Evaluation';
                            Image = List;
                            RunObject = Page "Supplier Evaluation List2";
                            RunPageLink = Stage = const(Preliminary);
                        }
                        action("Technical supplier evaluation2")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            Caption = 'Technical Supplier Evaluation';
                            RunObject = Page "Supplier Evaluation List2";
                            RunPageLink = Stage = const(Technical);
                        }
                        action("Supplier Evaluation-Pricing2")
                        {
                            Visible = false;
                            Caption = 'Supplier Evaluation-Pricing';
                            Image = List;
                            RunObject = Page "Supplier Evaluation Approved";
                            RunPageLink = Stage = const(Prices);
                        }
                        action("Submitted Supplier Evaluation2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Submitted Supplier Evaluation';
                            Image = List;
                            RunObject = Page "Submitted Supplier Eval RFP";
                            // RunPageLink = Status = const(Approved);
                        }
                        action("Supplier Evaluation Setup2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Supplier Evaluation Score Setup';
                            Image = List;
                            RunObject = Page "Supplier Evaluation Setup3";
                        }
                    }
                    group("RFP Opening")
                    {
                        action("RFP Quotations")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open RFP list';
                            image = List;
                            RunObject = page "RFP List";
                            RunPageLink = Status = CONST(Opening);
                        }
                    }
                    group("RFP Evaluation")
                    {
                        Caption = 'RFP Evaluation';

                        action("RFP evaluation list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "RFP Evaluation List";
                            RunPageLink = Status = filter(New), stage = const(Evaluation);
                        }
                        action("RFP evaluation archive list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "RFP EvaluationArchive List";
                            RunPageLink = stage = const(Evaluation);
                        }
                    }
                    group("RFP Negotiation")
                    {
                        action("RFP negotiation list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "RFP Evaluation";
                            RunPageLink = Status = filter(<> Approved), stage = const(Negotiation);
                        }
                        action("RFP negotiation list-Submitted")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "RFP Evaluation";
                            RunPageLink = Status = const(Approved), stage = const(Negotiation);
                        }
                    }
                    group("Specialized RFP contract committee")
                    {
                        action("Specialized contract RFP list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "RFP Evaluation";
                            RunPageLink = Status = filter(<> Approved), stage = const(Specialized);
                        }
                        action("Specialized contract RFP Submitted")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "RFP Evaluation";
                            RunPageLink = Status = const(Approved), stage = const(Specialized);
                        }
                    }
                    group("RFP archives")
                    {
                        Caption = 'Archives';

                        action("RFP archive list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = page "RFP Archive List";
                        }
                    }
                }
                group("EOI")
                {
                    Caption = 'EOI';

                    action("EOI List")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = page "EOI List";
                    }
                    group("EOI Committees")
                    {
                        group("EOI Opening Committee")
                        {
                            Caption = 'Opening Committee';

                            action("Open Opening EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "EOI Committee Creation";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Opening EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "EOI Committee Creation";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("EOI Evaluation Committee")
                        {
                            Caption = 'Evaluation Committee';

                            action("Open Evalation EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Evaluation EOI Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Evaluation EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Evaluation EOI Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("EOI Inspection Committee")
                        {
                            Caption = 'Inspection and Acceptance Committee';

                            action("Open Inspection EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "EOI Inspection Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Inpection EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "EOI Inspection Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("EOI negotiation Committee")
                        {
                            Caption = 'Negotiation Committee';

                            action("Open negotiation EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Negotiation EOI Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Negotiation EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Negotiation EOI Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                        group("EOI Special Committee")
                        {
                            Caption = 'complex and specialized contract implementation committee';

                            action("Open Special EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Open Committee';
                                image = List;
                                RunObject = page "Specialized EOI Committee";
                                RunPageLink = Status = const(Open);
                            }
                            action("Approved Special EOI Committee")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Approved Committee';
                                image = List;
                                RunObject = page "Specialized EOI Committee";
                                RunPageLink = Status = const(Released);
                                RunPageMode = View;
                            }
                        }
                    }
                    group("Suppliers Evaluation3")
                    {
                        Caption = 'Suppliers Evaluation';

                        action("Preliminary Supplier Evaluation3")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Preliminary Supplier Evaluation';
                            Image = List;
                            RunObject = Page "Supplier Evaluation List1";
                            RunPageLink = Stage = const(Preliminary);
                        }
                        action("Technical Supplier Evaluation3")
                        {
                            Caption = 'Technical Supplier Evaluation';
                            Visible = false;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Supplier Evaluation List1";
                            RunPageLink = Stage = const(Technical);
                            Image = List;
                        }
                        action("Supplier Evaluation-Pricing3")
                        {
                            Visible = false;
                            Caption = 'Supplier Evaluation-Pricing';
                            Image = List;
                            RunObject = Page "Supplier Evaluation Approved";
                            RunPageLink = Stage = const(Prices);
                        }
                        action("Submitted Supplier Evaluation3")
                        {
                            // Visible = false;
                            ApplicationArea = Basic, Suite;
                            Caption = 'Submitted Supplier Evaluation';
                            Image = List;
                            RunObject = Page "Supplier Evaluation List1";
                            RunPageLink = Status = const(Approved);
                        }
                        action("Supplier Evaluation Setup3")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Supplier Evaluation Score Setup';
                            Image = List;
                            RunObject = Page "Supplier Evaluation Setup2";
                        }
                    }
                    group("EOI Opening")
                    {
                        action("EOI Quotations")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Open EOI list';
                            image = List;
                            RunObject = page "EOI List";
                            RunPageLink = Status = CONST(Opening);
                        }
                    }
                    group("EOI Evaluation")
                    {
                        Caption = 'EOI Evaluation';

                        action("EOI evaluation list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "EOI Evaluation List";
                            RunPageLink = Status = filter(New), stage = const(Evaluation);
                        }
                        action("EOI evaluation archive list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "EOI Evaluation List";
                            RunPageLink = Status = const(Approved), stage = const(Evaluation);
                        }
                    }
                    group("EOI Negotiation")
                    {
                        action("EOI negotiation list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "EOI Evaluation List";
                            RunPageLink = Status = filter(<> Approved), stage = const(Negotiation);
                        }
                        action("EOI negotiation list-Submitted")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "EOI Evaluation List";
                            RunPageLink = Status = const(Approved), stage = const(Negotiation);
                        }
                    }
                    group("Specialized EOI contract committee")
                    {
                        action("Specialized contract EOI list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "EOI Evaluation List";
                            RunPageLink = Status = filter(<> Approved), stage = const(Specialized);
                        }
                        action("Specialized contract EOI Submitted")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = Page "EOI Evaluation List";
                            RunPageLink = Status = const(Approved), stage = const(Specialized);
                        }
                    }
                    group("EOI archives")
                    {
                        Caption = 'Archives';

                        action("EOI archive list")
                        {
                            ApplicationArea = Basic, Suite;
                            Image = List;
                            RunObject = page "EOI Archive List";
                            RunPageLink = Status = const(Archived);
                        }
                    }
                }
                group("Prospective Suppliers")
                {
                    Caption = 'Prospective Suppliers';

                    action("Supplier List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Supplier Portal Responses';
                        Image = List;
                        RunObject = Page "Prospective Supplier List";
                        RunPageLink = Submitted = const(false);
                    }
                    action("Submitted Supplier List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Submitted Supplier Portal Responses';
                        Image = List;
                        RunObject = Page "Prospective Supplier List";
                        RunPageLink = Submitted = const(true);
                    }
                    action("Suppliers Under Evaluation List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Suppliers Under Evaluation';
                        Image = List;
                        RunObject = Page "Prospective Supplier List";
                        RunPageLink = "Supplier Status" = const(Evaluation);
                    }
                    action("Ethnicity List")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = List;
                        RunObject = Page "Ethnic Communities";
                    }
                }
                group("Supplier Portal Applications")
                {
                    action("Open Portal Supplier Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Prospective Supplier Applications';
                        Image = List;
                        RunObject = page "Open Prospective Supplier List";
                    }
                    action("Pending Portal App")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Approval Suppliers Applications';
                        Image = List;
                        RunObject = page "Pending Prospective Suppliers";
                    }
                    action("Approved Supplier Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Supplier Application';
                        Image = List;
                        RunObject = page "Approved Prospective Suppliers";
                    }
                    action("Rejected Supplier Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Supplier Application';
                        Image = List;
                        RunObject = page "Rejected Prospective Suppliers";
                    }
                }
                action("Prequalified Suppliers  ")
                {
                    Caption = 'Registered Suppliers';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Prequalified Suppliers";
                }
                action("Supplier Categories Report")
                {
                    Caption = 'Supplier Categories Report';
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Supplier Categories";
                }
                group("Order Inspection and Acceptance")
                {
                    group("Committee")
                    {
                        action("Inspection Committee")
                        {
                            ApplicationArea = Basic, Suite;
                            image = List;
                            RunObject = page "Inspection Committee";
                            RunPageLink = Status = const(Open);
                        }
                        action("Approved Inspection Committee")
                        {
                            ApplicationArea = Basic, Suite;
                            image = List;
                            RunObject = page "Inspection Committee";
                            RunPageLink = Status = const(Released);
                            RunPageMode = View;
                        }
                    }
                    group("Orders under inspection")
                    {
                        action("Open Inspection List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Inspection List";
                            RunPageLink = Status = filter(<> Released);
                        }
                        action("Archived Inspections List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Inspection List";
                            RunPageLink = Status = filter(Released);
                        }
                    }
                }
                group("Procs Report")
                {
                    Caption = 'Procurement Reports';

                    action("Bidders Report")
                    {
                        Caption = 'Bidders';
                        ApplicationArea = All;
                        RunObject = report "List of Bidders";
                    }
                    action("Purch History")
                    {
                        Caption = 'Purchase History';
                        ApplicationArea = All;
                        RunObject = report "Purch HistorySupplier";
                    }
                    action("Procurement Summary Report")
                    {
                        ApplicationArea = Basic, Suite;
                        //RunObject = report "Procurement Summary Report";
                        RunObject = report "Procurement Summary Report1";
                    }
                }
            }
            group("Order Processings")
            {
                Caption = 'Order Processing';

                action(Contacts)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Contact List";
                }
                action("Procurement Plan")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Procurement Plans";
                }
                action("Purchase quote ")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Purchase Quotes";
                }
                action("Purchase Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Image = "Order";
                    RunObject = Page "Purchase Order List";
                    RunPageLink = Archived = const(false);
                }
                action("Ammend Purchase Orders")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Ammend Purchase Order List";
                }
                action("Acknowledgement Notes")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Acknowledgement List";
                }
                action("Purchase Order- Released")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Purchase  Receiving MOD";
                }
                action("Purchase Orders-Old LPO's")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Purchase Order List- Old LPO";
                }
                action("Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Purchase Invoices";
                }
                action("Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Purchase Credit Memos";
                }
                group(Archives)
                {
                    action("Archived Purchase Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = "Order";
                        RunObject = Page "Purchase Order- Archived";
                    }
                }
            }
            group("Supplier Performance Evaluation")
            {
                action("Supplier Performance Evaluation List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Vendor Evaluation List";
                    RunPageLink = Status = const(New);
                }
                action("Pending Supplier Performance Evaluation List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Vendor Evaluation List";
                    RunPageLink = Status = const("Pending Approval");
                }
                action("Approved Supplier Performance Evaluation List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Vendor Evaluation List";
                    RunPageLink = Status = const(Approved);
                }
                action("Supplier Performance Evaluation Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Vendor Evaluation Setup";
                }
                action("Supplier Performance Evaluation Periods")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Vendor Evaluation Periods";
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
                action("Fixed Asset Disposal2")
                {
                    Caption = 'Fixed Asset Disposal';
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
            Group("Assets")
            {
                group("Asset Allocations")
                {
                    action("Open Asset Allocation")
                    {
                        RunObject = page "Asset Allocation List";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Pending Approval Asset Allocation")
                    {
                        RunObject = page "Asset Allocation List";
                        RunPageLink = Status = filter("Pending Approval");
                    }
                    action("Approved Asset Allocation")
                    {
                        RunObject = page "Asset Allocation List";
                        RunPageLink = Status = filter(Released), Allocated = const(false);
                    }
                }
                group("Asset Disposal")
                {
                    action("Approved FA Asset Disposal")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Prospective Customer List";
                    }
                    action("Open Disposal Quotation List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "FA Disposal Quote List";
                    }
                    action("Submitted Diposal Quotation List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "FA Disposal Quote List";
                    }
                }
                group("Asset Transfers")
                {
                    action("Asset Transfer")
                    {
                        RunObject = page "Asset Transfer List";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Pending Approval Asset Transfers")
                    {
                        RunObject = page "Asset Transfer List";
                        RunPageLink = Status = filter("Pending Approval");
                    }
                    action("Approved Asset Transfers")
                    {
                        RunObject = page "Asset Transfer List";
                        RunPageLink = Status = filter(Released), Transferred = const(false);
                    }
                }
                group("Fixed Asset Disposal")
                {
                    action("Open Annual Disposal Plan")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Annual Asset  Disposal";
                    }
                    action("Annual Asset Disposal Plan")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Annual Asset  Disposal";
                    }
                    action("FA Disposal")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = Bin;
                        RunObject = page "FA Disposal List";
                        RunPageLink = Status = filter(<> Approved);
                    }
                    action("FA Disposal-Approved")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = Bin;
                        RunObject = page "FA Disposal List";
                        RunPageLink = Status = const(Approved);
                    }
                    action("Fixed Assets Marked For Disposal")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = Bin;
                        RunObject = page "FA Marked For Disposal List";
                    }
                }
            }
            group(Payables)
            {
                Caption = 'Payables';

                action("Vendors12")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    RunObject = page "Vendor List";
                    RunPageLink = "Vendor Type" = filter(<> "Share holder");
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
                }
            }
            group("Suppliers ")
            {
                action("Suppliers")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Vendor List";
                    RunPageLink = "Vendor Type" = const(Vendor);
                }
            }
            group(Tracking)
            {
                action("Procurement Status Check")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Purchase Request-Tracking";
                }
            }
            group("Inventory and Costing")
            {
                action(Items)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Item List";
                }
                action("Nonstock Items")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Catalog Item List";
                }
                action("Stockkeeping Units")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Stockkeeping Unit List";
                }
                action("Physical Inventory List")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Physical Inventory List';
                    RunObject = report "Phys. Inventory List";
                }
                action("Phys. Inventory Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Physical Inventory Journals';
                    RunObject = page "Phys. Inventory Journal";
                }
                action("Monthly Inventory Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Monthly Inventory Report';
                    RunObject = report "Monthly Inventory Report";
                }
            }
            group("Inventory  Setup")
            {
                action("Units of Measure")
                {
                    RunObject = Page "Units of Measure";
                }
            }
            group(Stores)
            {
                action("Item Transfer List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Item Transfer List";
                }
            }
            group("Procurement and Stores Setups")
            {
                Image = Setup;

                action("Supplier Category")
                {
                    ApplicationArea = Basic, Suite;
                    //Caption = 'Supply Codes';
                    RunObject = Page "Supplier Category";
                }
                action("Supplier Types")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Supplier Type";
                }
                action(Prequalifications)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page Prequalifications;
                }
                action("Procurement Methods")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Procurement Methods List";
                }
                action("Termination Methods")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Termination Methods";
                }
                action("Procurement Documents Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Procurement Documents Setup";
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;

                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Return Shipments")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Open the list of posted return shipments.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("Posted Assembly Orders")
                {
                    ApplicationArea = Assembly;
                    Caption = 'Posted Assembly Orders';
                    RunObject = Page "Posted Assembly Orders";
                    ToolTip = 'View completed assembly orders.';
                }
            }
            Group("Contract Management")
            {
                Group("Contract Creation1")
                {
                    Caption = 'Contract Creation';

                    action("Contract Creation")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Projects List";
                        //RunPageView = where(field());
                    }
                    action("Contracts Verified")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Projects Verified";
                    }
                    action("Direct Contracts")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contracts List";
                    }
                    action("Direct Contracts Verified")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Projects Verified";
                    }
                }
                action("Running Contracts")
                {
                    image = List;
                    ApplicationArea = all;
                    RunObject = page "Projects Approved";
                }
                action("Direct Running Contracts")
                {
                    image = List;
                    ApplicationArea = all;
                    RunObject = page "Direct Running Contracts";
                }
                action("Contract Extension Requests")
                {
                    Caption = 'Contract Change Requests';
                    ApplicationArea = all;
                    RunObject = page "Contract Change List";
                }
                group("Contract Extension")
                {
                    action("Open Contract Extensions")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Open Contract Extensions";
                    }
                    action("Pending Contract Extensions")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Pending Contract Extensions";
                    }
                    action("Contracts Extended")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Contracts Extended";
                    }
                    action("Direct Contract Extension")
                    {
                        Caption = 'Direct Contracts';
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Extensions";
                        RunPageView = where("Extension Status" = const(Open));
                    }
                    action("Direct Contract  Ext Pending")
                    {
                        Caption = 'Pending Direct Contracts';
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Extensions";
                        RunPageView = where(Status = const("Pending Approval"));
                    }
                    action("Direct Contract Ext Approved")
                    {
                        Caption = 'Approved Direct Contracts';
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Extensions";
                        RunPageView = where(Status = const(Approved));
                    }
                }
                group("Contract Suspension")
                {
                    action("Open Contract Suspensions")
                    {
                        Visible = false;
                        Caption = 'Contract Suspensions';
                        Image = List;
                        ApplicationArea = all;
                        //RunObject = page "Open Contract Suspensions";
                    }
                    action("Pending Contract Suspensions")
                    {
                        Visible = false;
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Pending Contract Suspensions";
                    }
                    action("Contract Suspended")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Projects Suspended";
                    }
                    action("Direct Contract Suspensions")
                    {
                        Visible = false;
                        Image = List;
                        Caption = 'Open Direct Contract Suspensions';
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Suspensions";
                        RunPageView = WHERE(Status = CONST("Pending Suspension"));
                    }
                    action("Pending Direct Suspensions")
                    {
                        Visible = false;
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Suspensions";
                        RunPageView = WHERE(type = CONST("Suspension"), Status = const("Pending Approval"));

                        ;
                    }
                    action("Direct Contracts Suspended")
                    {
                        Image = List;
                        ApplicationArea = all;
                        RunObject = page "Direct Contract Suspensions";
                    }
                }
                action("Contracts Terminated")
                {
                    ApplicationArea = all;
                    RunObject = page "Contracts Terminated";
                }
                action("Terminated Direct Contracts")
                {
                    Caption = 'Terminated Direct Contracts';
                    Image = List;
                    ApplicationArea = all;
                    RunObject = page "Direct Contracts Terminated";
                }
                action("Contracts Finished")
                {
                    image = List;
                    ApplicationArea = all;
                    RunObject = page "Projects Finished";
                }
                action("Direct Contracts Finished")
                {
                    image = List;
                    ApplicationArea = all;
                    RunObject = page "Finished Direct Contracts";
                }
                action("Contract Report")
                {
                    Caption = 'Contract Register';
                    Image = Report;
                    ApplicationArea = all;
                    RunObject = report "Contract Register";
                }
                action("Contract General Conditions Setup")
                {
                    ApplicationArea = all;
                    Caption = 'General Contract Condtions Setup';
                    RunObject = page "Contract General Conditions";
                }
                action("Contract Terms And Conditions")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Terms And Conditions';
                    RunObject = page "Contract Terms And Conditions";
                }
                action("Contract Committees")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Committee';
                    RunObject = page "Contract Committee List";
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
                action("Order Due days Setup")
                {
                    ApplicationArea = basic, suite;
                    RunObject = page "Order Due days Threshold";
                }
                action("Financial Year")
                {
                    ApplicationArea = all;
                    RunObject = page "Financial Year";
                }
            }
        }
    }
}

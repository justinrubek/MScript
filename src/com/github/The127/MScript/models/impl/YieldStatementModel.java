package com.github.The127.MScript.models.impl;

import com.github.The127.MScript.FileContext;
import com.github.The127.MScript.models.IScriptContext;

public class YieldStatementModel extends StatementModel  {

	public YieldStatementModel(FileContext ctx) {
		super(ctx);
	}

	@Override
	public String compile(IScriptContext ctx) {
		return "yield" + System.lineSeparator();
	}

}
